class MigrateCustomersWorker
  include Sidekiq::Worker

  def initialize(start, limit)
    @start = start
    @limit = limit
  end

  def perform
    fetch_main_list
    if @main_list.count > 0
      @main_list.each do |customer|
        Customer.create_from_api(customer)
      end
      cleanup_process
    end
  end

  def add_products
    fetch_customer_product_list
    @customer_product_list.each do |cpl|
      CustomerProduct.create_from_api(cpl)
    end
  end

private

  def fetch_main_list
    @response = get_response(EES_API_GET_CUSTOMERS_URI)
    @main_list = process_response
  end

  def fetch_customer_product_list
    @response = get_response(EES_API_GET_CUSTOMER_PRODUCT_URI)
    @customer_product_list = process_response
  end


  def cleanup_process
    Customer.reset_auto_inc
  end

  def get_response(api_uri)
    remote_connection.post do |req|
      req.url api_uri
      req.headers['Content-Type'] = 'application/json'
      req.body = post_data
    end
  end

  def process_response
    response_body = JSON.parse(@response.body)
    JSON.parse(response_body["Value"])
  end

  def remote_connection
    conn = Faraday.new(url: EES_API_BASE_URL) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def post_data
    { "username": EES_API_USERNAME, "password": EES_API_PASSWORD, "start": @start, "limit": @limit }.to_json
  end
end
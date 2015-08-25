class MigrateProductsWorker
  include Sidekiq::Worker

  def initialize(start, limit)
    @start = start
    @limit = limit
  end

  def perform
    fetch_product_list
    if @product_list.count > 0
      @product_list.each do |product|
        Product.create_from_api(product)
        update_product_types(product)
      end
      cleanup_process
    end
  end

  def update_product_types(product)
    fetch_product_type_list
    fetch_product_sub_type_list

    product_obj = Product.find(product["Id"])

    sub_type_data = set_sub_type_data(product)[0]
    type_data = set_type_data(sub_type_data)[0]
    ProductType.create_from_api(type_data)
    ProductSubType.create_from_api(sub_type_data)

    product_obj.product_type = ProductType.find(type_data["Id"])
    product_obj.product_sub_type = ProductSubType.find(sub_type_data["Id"])
    product_obj.save
  end

private

  def fetch_product_list
    @response = get_response(EES_API_GET_PRODUCT_URI)
    @product_list = process_response
  end

  def fetch_product_type_list
    @limit = 50
    @response = get_response(EES_API_GET_PRODUCT_TYPE_URI)
    @product_types = process_response
  end

  def fetch_product_sub_type_list
    @response = get_response(EES_API_GET_PRODUCT_SUB_TYPE_URI)
    @product_sub_types = process_response
  end

  def cleanup_process
    Product.reset_auto_inc
    ProductType.reset_auto_inc
    ProductSubType.reset_auto_inc
  end

  def set_sub_type_data(product)
    @product_sub_types.select{ |pst| pst['Id'] == product["ProductSubType"] }
  end

  def set_type_data(sub_type)
    @product_types.select{ |pt| pt['Id'] == sub_type["ProductTypeId"] }
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
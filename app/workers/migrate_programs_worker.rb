class MigrateProgramsWorker
  include Sidekiq::Worker

  # EES_API_GET_PROGRAM_URI
  # EES_API_GET_PROGRAM_PRODUCT_PRICE_URI

  def initialize(start, limit)
    @start = start
    @limit = limit
  end

  def perform
    fetch_main_list
    if @main_list.count > 0
      @main_list.each do |program|
        Program.create_from_api(program)
        connect_product_with_program(program)
      end
      cleanup_process
    end
  end

private

  def connect_product_with_program(program)
    fetch_program_product_list
    product_program_data = @product_program_list.select { |ppl| program['Id'] }[0]
    ProductProgramPrice.create_from_api(product_program_data)
  end

  def fetch_main_list
    @response = get_response(EES_API_GET_PROGRAM_URI)
    @main_list = process_response
  end

  def fetch_program_product_list
    @response = get_response(EES_API_GET_PROGRAM_PRODUCT_PRICE_URI)
    @product_program_list = process_response
  end

  def cleanup_process
    Program.reset_auto_inc
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
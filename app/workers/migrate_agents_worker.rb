class MigrateAgentsWorker
  include Sidekiq::Worker

  def perform(start, limit)
    @agent_list = self.class.fetch_agent_list(start, limit)
    # puts "-----------Fetched #{@agent_list.count} agents."

    if @agent_list.count > 0
      @agent_list.each do |agent|
        if Agent.create_from_api(agent)
          # puts "-----------Processing agent: #{agent['AgentId']}."
        else
          raise "-----------There was an issue creating agent: #{agent['AgentId']}"
        end
      end

      cleanup_process
    else
      # puts "-----------No agents found. Exiting..."
    end

  end

  def self.fetch_agent_list(start, limit)
    begin
      post_data = { "username": EES_API_USERNAME, "password": EES_API_PASSWORD, "start": start, "limit": limit }
      conn = Faraday.new(url: EES_API_BASE_URL) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        # faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
      response = conn.post do |req|
        req.url EES_API_GET_AGENTS_URI
        req.headers['Content-Type'] = 'application/json'
        req.body = post_data.to_json
      end
      status = response.status
      response_body = JSON.parse(response.body)
      agent_list = JSON.parse(response_body["Value"])
    rescue => e
      Rollbar.error("uncaught #{e} exception while fetching agents: #{e.message}")
      agent_list = {}
    end
  end

  def cleanup_process
    Agent.reset_auto_inc
  end
end

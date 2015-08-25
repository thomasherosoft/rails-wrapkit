namespace :agents do
  # rake agents:migrate[1,5]
  desc "Migrate agents from API"
  task :migrate, [:start, :limit] => [:environment]do |t, args|
    # puts "-----------Migrating agents from API #{args}."
    MigrateAgentsWorker.new.perform(args[:start], args[:limit])
    # puts "-----------Done."
  end

  # rake agents:generate_json
  desc "Generate JSON for testing input"
  task :generate_json do
    json = MigrateAgentsWorker.fetch_agent_list(1, 3)
    File.open("spec/fixtures/agents.json","w") do |f|
      f.write(json.to_json)
    end
  end

end
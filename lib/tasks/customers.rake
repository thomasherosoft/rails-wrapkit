namespace :customers do
  # rake customers:migrate[1,5]
  desc "Migrate customers from API"
  task :migrate, [:start, :limit] => [:environment]do |t, args|
    # puts "-----------Migrating customers from API #{args}."
    MigrateCustomersWorker.new(args[:start], args[:limit]).perform
    # puts "-----------Done."
  end

  # rake customers:add_products[1,5]
  desc "Migrate customers products association from API"
  task :add_products, [:start, :limit] => [:environment]do |t, args|
    # puts "-----------Migrating customers from API #{args}."
    MigrateCustomersWorker.new(args[:start], args[:limit]).add_products
    # puts "-----------Done."
  end

  # rake customers:generate_json
  desc "Generate JSON for testing input"
  task :generate_json do
    json = MigrateCustomersWorker.fetch_customer_list(1, 3)
    File.open("spec/fixtures/customers.json","w") do |f|
      f.write(json.to_json)
    end
  end

end
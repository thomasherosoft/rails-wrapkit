namespace :products do
  # rake products:migrate[1,5]
  desc "Migrate products from API"
  task :migrate, [:start, :limit] => [:environment]do |t, args|
    migrate = MigrateProductsWorker.new(args[:start], args[:limit])
    migrate.perform
  end

  # rake products:generate_json
  desc "Generate JSON for testing input"
  task :generate_json do
    worker = MigrateProductsWorker.new(1, 5)
    json = worker.fetch_product_list
    File.open("spec/fixtures/products.json","w") do |f|
      f.write(json.to_json)
    end

    json2 = worker.fetch_product_type_list
    File.open("spec/fixtures/product_types.json","w") do |f|
      f.write(json2.to_json)
    end

    json3 = worker.fetch_product_sub_type_list
    File.open("spec/fixtures/product_sub_types.json","w") do |f|
      f.write(json3.to_json)
    end
  end

end
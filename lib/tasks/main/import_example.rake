# require 'ruby-progressbar' if Rails.env.development?
# require 'csv'


# ## NOTES run import
# ## then update sequence: rake import:update_sequence[feeds]


# namespace :import do

# # FEEDS

#   # USAGE EXAMPLE - rake import:feeds[feeds]
#   task :feeds, :filename, :starting_at, :destroy_all do |t, args|
#     args.with_defaults(:filename => 'feeds', :starting_at => 0, :destroy_all => 0)

#     csv_text = File.read("#{Rails.root}/lib/source/#{args[:filename]}.csv")
#     csv = CSV.parse(csv_text, :headers => false)

#     if args[:destroy_all] == '1'
#       STDOUT.puts "Are you sure you want to DESTROY All feeds? [y/n]"
#       input = STDIN.gets.chomp
#       raise "Task cancelled. Set second arg to 0 to skip destroy." unless input == "y"
#       puts "DESTROYING ALL FEEDS..."
#       Feed.destroy_all
#     end

#     puts "IMPORTING FEEDS..."

#     progressbar = ProgressBar.create(:title => "Importing", :total => csv.size, :format => '%a <%B> %p%% %t')

#     csv.each do |row|
#       progressbar.increment
#       next unless row[0].to_i > args[:starting_at].to_i

#       # Id,Title,Feed url,Site url,Etag,Created at,Updated at,Last modified,Subscriptions count,Protected,Push expiration
#       # t.text     "title"
#       # t.text     "feed_url"
#       # t.text     "site_url"
#       # t.text     "etag"
#       # t.datetime "created_at",                           null: false
#       # t.datetime "updated_at",                           null: false
#       # t.datetime "last_modified"
#       # t.integer  "subscriptions_count",  default: 0,     null: false
#       # t.boolean  "protected",            default: false
#       # t.datetime "push_expiration"
#       # t.datetime "last_published_entry"
#       # t.text     "host"

#       Feed.create!({
#         id: row[0],
#         title: row[1],
#         feed_url: row[2],
#         site_url: row[3],
#         etag: row[4],
#         created_at: row[5],
#         updated_at: row[6],
#         last_modified: row[7],
#         subscriptions_count: row[8] || 0,
#         protected: row[9],
#         push_expiration: row[10]
#       })

#       # # Update SEQUENCE
#       # table = 'feeds'
#       # auto_inc_val = row[0] # New auto increment start point
#       # ActiveRecord::Base.connection.execute(
#       #   "ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}"
#       # )

#     end

#     puts "COMPLETE - #{Time.now}"

#   end

# # SUBSCRIPTIONS

#   # USAGE EXAMPLE - rake import:subscriptions[subscriptions-update,4000,0]
#   task :subscriptions, :filename, :starting_at, :destroy_all do |t, args|
#     args.with_defaults(:filename => 'subscriptions', :starting_at => 0, :destroy_all => 0)

#     csv_text = File.read("#{Rails.root}/lib/source/#{args[:filename]}.csv")
#     csv = CSV.parse(csv_text, :headers => false)

#     if args[:destroy_all] == '1'
#       STDOUT.puts "Are you sure you want to DESTROY All subscriptions? [y/n]"
#       input = STDIN.gets.chomp
#       raise "Task cancelled. Set second arg to 0 to skip destroy." unless input == "y"
#       puts "DESTROYING ALL SUBSCRIPTIONS..."
#       Feed.destroy_all
#     end

#     puts "IMPORTING SUBSCRIPTIONS..."

#     progressbar = ProgressBar.create(:title => "Importing", :total => csv.size, :format => '%a <%B> %p%% %t')

#     csv.each do |row|
#       progressbar.increment
#       next unless row[0].to_i > args[:starting_at].to_i
#       # t.integer  "user_id"
#       # t.integer  "feed_id"
#       # t.datetime "created_at",                   null: false
#       # t.datetime "updated_at",                   null: false
#       # t.text     "title"
#       # t.boolean  "view_inline",  default: false
#       # t.boolean  "active",       default: true
#       # t.boolean  "push",         default: false
#       # t.boolean  "show_updates", default: true
#       # t.boolean  "muted",        default: false

#       Subscription.create!({
#         id: row[0],
#         user_id: row[1],
#         feed_id: row[2],
#         created_at: row[3],
#         updated_at: row[4],
#         title: row[5],
#         view_inline: row[6] || 0,
#         active: row[7] || 0,
#         push: row[8] || 0,
#         show_updates: row[9] || 0,
#         muted: row[10] || 0
#       })

#     end

#     puts "Import Complete #{Time.now}"

#   end

# # TAGS

#   task tags: :environment do

#     csv_text = File.read(Rails.root + 'lib/source/tags.csv')
#     csv = CSV.parse(csv_text, :headers => false)

#     puts "IMPORTING TAGS..."

#     progressbar = ProgressBar.create(:title => "Importing", :total => csv.size, :format => '%a <%B> %p%% %t')

#     csv.each do |row|
#       # puts "processing # #{count}"
#       # t.string   "name"
#       # t.datetime "created_at", null: false
#       # t.datetime "updated_at", null: false

#       Tag.create!({
#         id: row[0],
#         name: row[1],
#         created_at: row[2],
#         updated_at: row[3]
#       })
#       progressbar.increment

#     end

#     puts "Import Complete #{Time.now}"

#   end

# # TAGGINGS

#   task taggings: :environment do

#     csv_text = File.read(Rails.root + 'lib/source/taggings.csv')
#     csv = CSV.parse(csv_text, :headers => false)

#     puts "IMPORTING TAGGINGS..."

#     progressbar = ProgressBar.create(:title => "Importing", :total => csv.size, :format => '%a <%B> %p%% %t')

#     csv.each do |row|

#       # t.integer  "feed_id"
#       # t.integer  "user_id"
#       # t.datetime "created_at", null: false
#       # t.datetime "updated_at", null: false
#       # t.integer  "tag_id"

#       # Id,Tag,Feed,User,Created at,Updated at
#       Tagging.create!({
#         id: row[0],
#         tag_id: row[1],
#         feed_id: row[2],
#         user_id: row[3],
#         created_at: row[4],
#         updated_at: row[5]
#       })
#       progressbar.increment

#     end

#     puts "Import Complete #{Time.now}"

#   end

# # BILLING EVENTS WIP

#   task billing_events: :environment do

#     # csv_text = File.read(Rails.root + 'lib/source/taggings.csv')
#     # csv = CSV.parse(csv_text, :headers => false)

#     file = File.read(Rails.root + 'lib/source/billing_events.json')

#     data_hash = JSON.parse(file)
#     # puts data_hash.to_s
#     # puts JSON.pretty_generate(data_hash)


#     puts "IMPORTING BILLING_EVENTS..."
#     progressbar = ProgressBar.create(:title => "Importing", :total => csv.size, :format => '%a <%B> %p%% %t')

#     data_hash.values.each do |row|
#       puts row[0]
#       progressbar.increment
#     end

#     puts "Import Complete #{Time.now}"

#   end



# # CLEANUP AUTO increment
# # :feeds, :filename, :starting_at, :destroy_all do |t, args|
#   task :update_sequence, :table do |t, args|

#     table = args[:table]
#     raise "Pass table arg: rake import:update_sequence[table_name]" if !table

#     result = ActiveRecord::Base.connection.execute("SELECT id FROM #{table} ORDER BY id DESC LIMIT 1")
#     if result.any?
#       ai_val = result.first['id'].to_i + 1
#       puts "Resetting auto increment ID for #{table} to #{ai_val}"
#       ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
#     end
#     # ActiveRecord::Base.connection.tables.each do |table|
#     #   result = ActiveRecord::Base.connection.execute("SELECT id FROM #{table} ORDER BY id DESC LIMIT 1")
#     #   if result.any?
#     #     ai_val = result.first['id'].to_i + 1
#     #     puts "Resetting auto increment ID for #{table} to #{ai_val}"
#     #     ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
#     #   end
#     # end
#   end



# end
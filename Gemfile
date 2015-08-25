source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails', '4.2.1'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'sidekiq'
gem 'sinatra'
gem 'puma'
gem 'faraday', '~> 0.9.1'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise'
gem 'devise_token_auth'
gem 'pundit'
gem 'haml-rails'
gem 'twitter-bootstrap-rails'
gem 'jquery-ui-rails'
gem 'font-awesome-rails'
gem 'ajax-datatables-rails', github: 'antillas21/ajax-datatables-rails', branch: 'v-0-4-0'
gem 'spinjs-rails'
gem 'simple_form'
gem 'paperclip', '~> 4.2'
gem 'airbrake'
gem 'faker'
gem 'factory_girl'
gem 'versionist'
gem 'pry'

group :development, :test do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'spring-commands-rspec'
  gem 'vcr'
  gem 'rubocop'
  gem 'haml_lint'
end

group :test do
  gem 'webmock'
  gem 'shoulda-matchers'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'selenium-webdriver'
end

group :development do #access at rails/routes
  gem 'sextant'
  gem 'letter_opener'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'meta_request'

  gem 'zeus'
  gem 'guard-livereload', '~> 2.4', require: false
  gem 'guard-zeus'
  gem 'guard-rails', github: 'adibsaad/guard-rails'
  gem 'rack-livereload'

  gem 'rails-erd'
  gem 'rails_best_practices'
  gem 'bullet'
end

group :production do
  gem 'rails_12factor'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap3-dialog'
end

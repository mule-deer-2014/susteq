source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.1.5'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer',  platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'haml'
gem 'haml-rails'
gem 'tzinfo-data', platforms: [:mingw, :mswin]
gem 'bcrypt', '~> 3.1.7'
gem 'paloma'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'jasmine-rails'
end

group :production, :test do
  gem 'faker'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
end

gem 'twitter-typeahead-rails'

group :production do
  gem 'rails_12factor'
  gem 'thin'
end

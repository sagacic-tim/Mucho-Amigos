source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Rails
gem "rails", "~> 7.0.8"

# Database
gem 'pg', '~> 1.5', '>= 1.5.3' -- --with-pg-config=/opt/local/lib/postgresql84/bin/pg_config
gem 'activerecord-postgis-adapter'

# Puma
gem 'puma', '~> 6.3'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS),
# making cross-origin AJAX possible
gem "rack-cors"

# Devise and related authentication gems
gem 'devise', '~> 4.8'
gem 'devise-jwt', '~> 0.11.0'
gem 'jwt', '~> 2.2', '>= 2.2.1'
gem 'omniauth', '~> 2.1', '>= 2.1.1'
gem 'omniauth-google-oauth2', '~> 1.1', '>= 1.1.1'
gem 'omniauth-facebook', '~> 9.0'
gem 'omniauth-github', '~> 2.0', '>= 2.0.1'
gem 'omniauth-linkedin-oauth2', '~> 1.0', '>= 1.0.1'
gem 'dotenv', '~> 2.8', '>= 2.8.1'
gem 'responders', '~> 3.0', '>= 3.0.1'

# Serialization
gem 'jbuilder', '~> 2.11'
gem 'jsonapi-serializer', '~> 2.2'

# Address Validation
gem 'smartystreets_ruby_sdk'

# Email and Phone Validation
gem 'email_validator', '~> 2.0'
gem 'phonelib', '~> 0.7.0'

# Additional Gems for Country and State Data
gem 'countries', '~> 5.6', require: 'countries/global'
gem 'bigdecimal', require: true
  # Windows does not include zoneinfo files, so bundle the
  # tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Preview email in the default browser instead of sending it.
  # This means you do not need to set up email delivery in your
  # development environment, and you no longer need to worry about
  # accidentally sending a test email to someone else's address.
  gem 'letter_opener', '~> 1.8', '>= 1.8.1'
end
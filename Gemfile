source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.7"

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5', '>= 1.5.3'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.3'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", '~> 2.11.5'

# Faker, a port of Data::Faker from Perl, is used to easily generate fake
# data: names, addresses, phone numbers, etc.
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'main'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1", "~> 3.1.13"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# Phonelib is a gem allowing you to validate phone numbers.
# All validations are based on Google libphonenumber. Cur-
# rently it can make basic validations and formatting to
# e164 international number format and national number for-
# mat with prefix. But it still doesn’t include all Google’s
# library functionality.
gem 'phonelib', '~> 0.8', '~> 0.8.3'

# The activerecord-postgis-adapter provides access to
# features of the PostGIS geospatial database from
# ActiveRecord. It extends the standard postgresql adapter
# to provide support for the spatial data types and features
# added by the PostGIS extension. It uses the RGeo library
# to represent spatial data in Ruby.
gem 'activerecord-postgis-adapter'

#  Here are a few examples showing how to use the Ruby SDK:
#
#   Verifying US street addresses
#   Verifying international street addresses
#   Finding US ZIP Codes
#   Extracting US street addresses from arbitrary text
#   Completing US street addresses given an prefix
#
gem 'smartystreets_ruby_sdk'

# An email validator for Rails 3+
# The default validation provided by this gem (the :loose
# configuration option) is extremely loose. It just checks
# that there's an @ with something before and after it
# without any whitespace.
#
# We understand that many use cases require an increased
# level of validation. This is supported by using the
# :strict validation mode.
gem 'email_validator', '~> 2.2', '>= 2.2.4'

# gem 'country_select' provides a simple helper to get an
# HTML select list of countries using the ISO 3166-1 standard.
#
# While the ISO 3166 standard is a relatively neutral source
# of country names, it may still offend some users. Developers
# are strongly advised to evaluate the suitability of this
# list given their user base.
gem 'country_select', '~> 8.0'

# BigDecimal provides similar support for very large or very
# accurate floating point numbers. Decimal arithmetic is also
# useful for general calculation, because it provides the correct
# answers people expect–whereas normal binary floating point
# arithmetic often introduces subtle errors because of the con-
# version between base 10 and base 2.
gem 'bigdecimal', '~> 3.1', '>= 3.1.4'

# Byebug is a Ruby debugger. It's implemented using the Trace-
# Point C API for execution control and the Debug Inspector C
# API for call stack navigation. The core component provides
# support that front-ends can build on. It provides breakpoint
# handling and bindings for stack frames among other things and
# it comes with an easy to use command line interface.
gem 'byebug', '~> 11.1', '>= 11.1.3'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end


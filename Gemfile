source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Devise is a flexible authentication solution for Rails based on
# Warden. It:
#   Is Rack based;
#   Is a complete MVC solution based on Rails engines;
#   Allows you to have multiple models signed in at the same time;
#   Is based on a modularity concept: use only what you really need.
gem 'devise', '~> 4.9', '>= 4.9.2'

# devise-jwt is a Devise extension which uses JWT tokens for user
# authentication. It follows secure by default principle.
gem 'devise-jwt', '~> 0.11.0'

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

# OmniAuth is a library that standardizes multi-provider
# authentication for web applications. It was created to
# be powerful, flexible, and do as little as possible. Any
# developer can create strategies for OmniAuth that can
# authenticate users via disparate systems. OmniAuth strat-
# egies have been created for everything from Facebook to LDAP.
gem 'omniauth', '~> 2.1', '>= 2.1.1'

# Strategy to authenticate with Google via OAuth2 in OmniAuth.
gem 'omniauth-google-oauth2', '~> 1.1', '>= 1.1.1'

# Supports OAuth 2.0 server-side and client-side flows.
# A secure, fast, and convenient way for users to log into
# your app, and for your app to ask for permissions to access
# data
gem 'omniauth-facebook', '~> 9.0'

# This is the official OmniAuth strategy for authenticating to
# GitHub. To use it, you'll need to sign up for an OAuth2
# Application ID and Secret on the GitHub Applications Page.
gem 'omniauth-github', '~> 2.0', '>= 2.0.1'

# A LinkedIn OAuth2 strategy for OmniAuth. OpenID Connect (OIDC)
# is an identity layer built on top of OAuth 2.0, enabling
# applications to authenticate members and obtain lite profile
# information about the member. OIDC will simplify the partner
# integration onboarding experience and eliminate dependencies
# on making additional API calls to find who the authenticated
# member is.
gem 'omniauth-linkedin-oauth2', '~> 1.0', '>= 1.0.1'

# A fast JSON:API serializer for Ruby Objects.
# Declaration syntax similar to Active Model Serializer
# Support for belongs_to, has_many and has_one
# Support for compound documents (included)
# Optimized serialization of compound documents
# Caching
gem 'jsonapi-serializer', '~> 2.2'

# A set of responders modules to dry up your Rails app.
gem 'responders', '~> 3.0', '>= 3.0.1'

# Provides Sprockets implementation for Rails 4.x (and beyond)
# Asset Pipeline
gem 'sprockets-rails', '~> 3.0', '>= 3.0.4', :require => 'sprockets/railtie'

# Countries is a collection of all sorts of useful information
# for every country in the ISO 3166 standard. It contains info
# for the following standards ISO3166-1 (countries), ISO3166-2
# (states/subdivisions), ISO4217 (currency) and E.164 (phone
# numbers).
gem 'countries', '~> 5.6', require: 'countries/global'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end


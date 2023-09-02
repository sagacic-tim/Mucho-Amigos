# if defined?(EmailValidator)
#   # To completely override the defaults
#   EmailValidator.default_options = {
#     allow_nil: false,
#     domain: nil,
#     require_fqdn: true,
#     mode: :strict
#   }

#   # or just a few options
#   EmailValidator.default_options.merge!({ domain: 'mydomain.com' })
# end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, 'GOOGLE_CLIENT_ID', 'GOOGLE_CLIENT_SECRET', { scope: 'email, profile' }

  provider :facebook, 'FACEBOOK_APP_ID', 'FACEBOOK_APP_SECRET', { scope: 'email, public_profile' }

  provider :github, 'GITHUB_KEY', 'GITHUB_SECRET', { scope: 'user:email' }

  provider :linkedin, 'LINKEDIN_KEY', 'LINKEDIN_SECRET', { scope: 'r_liteprofile r_emailaddress' }
end
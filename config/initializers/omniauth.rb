Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.secrets[:twitter][:key], Rails.application.secrets[:twitter][:secret]
  provider :facebook, Rails.application.secrets[:facebook][:key], Rails.application.secrets[:facebook][:secret]  
end
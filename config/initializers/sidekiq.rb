Sidekiq.configure_server do |config|
  config.redis = { url: "redis://10.11.12.13:6379", namespace: "sidekiq" }
end

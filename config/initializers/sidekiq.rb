Sidekiq.configure_server do |config|
  config.redis = { url: Rails.configuration.redis.host, namespace: Rails.configuration.redis.namespace }
end

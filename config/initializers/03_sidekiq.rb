config_file = Rails.root.join('config', 'sidekiq.yml')

sidekiq_url = if File.exists?(config_file)
                YAML.load_file(config_file)[Rails.env]
              else
                "redis://localhost:6379"
              end

Sidekiq.configure_server do |config|
  config.redis = {
    url: sidekiq_url,
    namespace: 'sidekiq:social'
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: sidekiq_url,
    namespace: 'sidekiq:social'
  }
end

set :stage, :production
set :rails_env, "production"

server '192.241.179.170', user: 'deploy', roles: %w{web app db sidekiq}

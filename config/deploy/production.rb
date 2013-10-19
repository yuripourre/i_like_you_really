set :stage, :production
set :rails_env, "production"

server '173.255.252.157', user: 'deploy', roles: %w{web app db}

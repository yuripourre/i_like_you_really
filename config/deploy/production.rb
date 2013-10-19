set :stage, :production

server '173.255.252.157', user: 'deploy', roles: %w{web app db}

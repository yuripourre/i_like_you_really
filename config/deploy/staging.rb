set :stage, :staging

server '10.11.12.13', user: 'deploy', roles: %w{web app db}

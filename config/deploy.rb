require "sidekiq/capistrano"

SSHKit.config.command_map[:rake] = "bundle exec rake"
SSHKit.config.command_map[:sidekiq] = "bundle exec sidekiq"
SSHKit.config.command_map[:sidekiq_ctl] = "bundle exec sidekiqctl"
SSHKit.config.command_map[:whenever] = "bundle exec whenever"

set :sidekiq_role, :sidekiq
set :sidekiq_cmd, :sidekiq
set :sidekiqctl_cmd, :sidekiq_ctl
set :sidekiq_timeout, 10
set :sidekiq_pid, "tmp/pids/sidekiq.pid"
set :sidekiq_options, "-e #{fetch(:rails_env, 'production')} -L /webapps/ilikeyoureally/current/log/sidekiq.log"
set :sidekiq_processes, 1

set :application, 'i_like_you_really'
set :repo_url, 'git@github.com:railsrumble/r13-team-421.git'

set :deploy_to, '/webapps/ilikeyoureally'
set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true
set :linked_files, %w{config/database.yml config/settings.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "kill -s USR2 `cat /tmp/puma_ilikeyoureally.pid`"
    end
  end

  after :finishing, 'deploy:cleanup'
end

set :environment, ENV["RAILS_ENV"] || "development"
set :output, error: "log/cron_error.log", standard: "log/cron.log"

every 1.minutes do
  runner "bundle exec rake interactor:run"
end

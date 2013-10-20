set :environment, ENV["RAILS_ENV"] || "development"
set :output, error: "log/cron_error.log", standard: "log/cron.log"

every 5.minutes do
  runner "MainWorker.perform_async"
end

set :environment, "development"

every 1.minutes do
  runner "MainWorker.perform_async", :output => {:error => 'error.log', :standard => 'cron.log'}
end

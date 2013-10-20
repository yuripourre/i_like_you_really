set :environment, "development"

every 3.minutes do
  runner "MainWorker.perform_async", :output => {:error => 'error.log', :standard => 'cron.log'}
end

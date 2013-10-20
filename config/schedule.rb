interval = Rails.configuration.preferences.worker_interval

every.interval.minutes do
  runner LikeCommentWorker.perform_async(current_user, interval)
end

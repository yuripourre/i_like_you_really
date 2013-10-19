class LikeCommentWorker
  include Sidekiq::Worker

  def perform
    interval = Rails.configuration.preferences.worker_interval
    token = "123mrtoken"
    api = Facebook.new(token)
    api.wall_since(interval.minutes.ago)
    true
  end
end

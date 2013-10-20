class ExpiredUsersWorker
  include Sidekiq::Worker

  def perform
    UserExpirationToken.new
  end
end

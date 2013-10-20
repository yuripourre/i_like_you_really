class LikeCommentWorker
  include Sidekiq::Worker

  def perform(ids)
    User.where(id: ids).find_each do |user|
      api = Facebook.new(user.access_token)
      Interactor.new(api, user).interact_with_latest_posts_from_friends
    end
  end
end

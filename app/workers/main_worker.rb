class MainWorker
  include Sidekiq::Worker

  def perform
    User.find_in_batches(batch_size: 20) {|group|
     LikeCommentWorker.perform_async(group)
    }
  end

end

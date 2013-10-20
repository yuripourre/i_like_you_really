class MainWorker
  include Sidekiq::Worker

  def perform
    User.find_in_batches(batch_size: 20) {|group|
      ids = [] 
      group.each {|u| ids << u.id } 
      LikeCommentWorker.perform_async(ids)
    }
  end

end

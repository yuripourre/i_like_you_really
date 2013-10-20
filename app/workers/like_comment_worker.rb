class LikeCommentWorker
  include Sidekiq::Worker

  def perform(users)
    interval = Rails.configuration.preferences.work_interval
    users.each {|user|
      friends_ids = user.marked_friends_ids
      random_comment = Comment.first(offset:rand(Comment.count))
      api = Facebook.new(user.access_token)
      posts = api.wall_since(interval.minutes.ago, friends_ids)["data"]
      posts.each {|post|
        send_to_stream = false
        activity = Activity.new
        friend = User.with_friend(post["actor_id"])
        like_permission = friend.like
        comment_permission = friend.comment
        if [true, false].sample 
          if like_permission
            api.like(post["post_id"])
            send_to_stream = true
            activity.like = true
          end
        end
        if [true, false].sample and random_comment
          if comment_permission
            api.comment(post["post_id"], random_comment)
            send_to_stream = true
            activity.comment = true
            activity.value = random_comment
          end
        end
        if send_to_stream?
          activity.object_id = post["post_id"]
          activity.user = user
          activity.save!
        end
      }
    }
  end
end

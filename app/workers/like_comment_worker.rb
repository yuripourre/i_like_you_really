class LikeCommentWorker
  include Sidekiq::Worker

  def perform(ids)
    ids.each {|id|
      user = User.find(id)
      friends_ids = user.marked_friends_ids * ","
      random_comment = user.comments.first(offset:rand(user.comments.count))
      api = Facebook.new(user.access_token)
      last_activity = user.activities.last
      diff_time =  Time.now - last_activity.created_at
      result = api.wall_since(diff_time.to_i, friends_ids)
      posts = result
      posts.each {|post|
        begin
          unless user.activities.where(object_id: post["post_id"]).any?
            send_to_stream = false
            activity = Activity.new
            friend = user.with_friend(post["actor_id"].to_s)
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
                api.comment(post["post_id"], random_comment.value)
                send_to_stream = true
                activity.comment = true
                activity.value = random_comment
              end
            end
            if send_to_stream
              activity.object_id = post["post_id"]
              activity.user = user
              activity.save!
            end
          end
        rescue Koala::Facebook::ClientError
        end
      }
    }
  end
end

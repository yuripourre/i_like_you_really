class LikeCommentWorker
  include Sidekiq::Worker

  def perform(ids)
    User.where(id: ids).find_each do |user|
      api = Facebook.new(user.access_token)

      with_new_posts_from(user, api) do |new_posts|
        interact_with_posts_using user, api, new_posts
      end
    end
  end

  def with_new_posts_from(user, api)
    last_activity = user.activities.try(:last).try(:created_at) || 1.hour.ago
    friends_ids   = user.marked_friends_ids.join(",")

    diff_time =  Time.now - last_activity
    yield api.wall_since(diff_time.to_i, friends_ids)
  rescue Koala::Facebook::ClientError => e
  end

  def feels_interactive?
    [true, false].sample
  end

  def maybe_like(object_id, api)
    will_like = feels_interactive?
    api.like(object_id) if will_like

    will_like
  rescue Koala::Facebook::ClientError
    false
  end

  def maybe_comment_on(object_id, user, activity, api)
    will_comment = feels_interactive?
    random_comment = user.comments.first(offset:rand(user.comments.count))
    api.comment(object_id, random_comment.value)
    activity = random_comment.value

    will_comment
  rescue Koala::Facebook::ClientError
    false
  end

  def interact_with_posts_using(user, api, new_posts)
    new_posts.each do |post|
      unless user.has_taken_notice_of_post?(object_id = post["post_id"])
        activity           = Activity.new
        friend             = user.with_friend(post["actor_id"].to_s)
        like_permission    = friend.like
        comment_permission = friend.comment

        has_commented    = comment_permission && maybe_comment_on(object_id, user, activity, api)
        has_liked        = like_permission && maybe_like(object_id, api)
        activity.like    = has_liked
        activity.comment = has_commented


        if has_liked || has_commented
          activity.object_id = post["post_id"]
          activity.friend_id = post["actor_id"].to_s
          activity.user = user
          activity.save!
        end
      end
    end
  end
end

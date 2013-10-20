class Interactor
  attr_reader   :api, :user
  private       :api, :user

  def initialize(facebook_api, user)
    @api  = facebook_api
    @user = user
  end

  def interact_with_latest_posts_from_friends
    with_latest_posts do |latest_posts|
      latest_posts.each { |post| interact_with post }
    end
  end

  private
  def with_latest_posts
    friends_ids = user.marked_friends_ids.join(",")
    timespan    = (Time.now - last_known_activity_creation).to_i

    yield api.wall_since(timespan, friends_ids)
  rescue Koala::Facebook::ClientError => e
    []
  end

  def interact_with(post)
    unless user.has_taken_notice_of_post?(post_id = post["post_id"])
      activity           = Activity.new
      friend             = user.fetch_friend(post["actor_id"])

      like_permission    = friend.like?
      comment_permission = friend.comment?
      has_commented      = comment_permission && maybe_comment_on(post_id, and_update: activity)
      has_liked          = like_permission && maybe_like(post_id)

      activity.like      = has_liked
      activity.comment   = has_commented
      activity.object_id = post["post_id"]
      activity.friend_id = post["actor_id"].to_s
      activity.user      = user

      activity.save!
    end
  end

  def maybe_comment_on(post_id, and_update: nil)
    will_comment = feels_interactive?

    if will_comment && (comment_text = random_comment_text)
      api.comment(post_id, comment_text)

      if (activity = and_update)
        activity.value = comment_text
      end
    end

    will_comment
  rescue Koala::Facebook::ClientError
    false
  end

  def maybe_like(post_id)
    will_like = feels_interactive?
    api.like(object_id) if will_like

    will_like
  rescue Koala::Facebook::ClientError
    false
  end

  def feels_interactive?
    [true, false].sample
  end

  def random_comment_text
    user.comments.first(offset: rand(user.comments.count)).try(:value)
  end

  def last_known_activity_creation
    user.activities.try(:last).try(:created_at) || 1.hour.ago
  end
end

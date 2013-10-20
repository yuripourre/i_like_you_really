class Facebook

  attr_reader :access_token, :graph

  def initialize(token)
    @access_token = token
    @graph = Koala::Facebook::API.new(@access_token)
  end

  def self.oauth
    Koala::Facebook::OAuth.new(Rails.configuration.facebook.app_id,
                               Rails.configuration.facebook.app_secret)
  end

  def friends
    @graph.get_connections("me", "friends")
  end

  def profile
    @graph.get_object("me")
  end

  def like(id)
    @graph.put_like(id)
  end

  def comment(id, message)
    @graph.put_comment(id, message)
  end

  def wall
    @graph.get_connection("me", "home")
  end

  def wall_since(since, friends)
    @graph.fql_query("SELECT post_id, actor_id, created_time FROM stream WHERE filter_key = 'nf'" << 
    "AND is_hidden = 0 AND created_time > #{since} AND actor_id in (#{friends})")
  end

  def wall_with_limit(limit)
    @graph.get_connection("me", "home?limit=#{limit}")
  end

  def picture(id)
    @graph.get_picture(id)
  end

  def get_object(object_id)
    @graph.get_object object_id
  end

end

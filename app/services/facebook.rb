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
    @graph.get_connection("me", "home?limit=100")
  end

  def wall_since(since)
    @graph.fql_query("SELECT post_id, actor_id, message FROM stream WHERE created_time > #{since} AND filter_key in" <<
    "(SELECT filter_key FROM stream_filter WHERE uid=me())")
  end

  def picture(id)
    @graph.get_picture(id)
  end

end

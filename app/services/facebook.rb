class Facebook

  attr_reader :access_token, :graph
  def initialize(token)
    @access_token =  token
    @graph = Koala::Facebook::API.new(@access_token)
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

  def wall(id)
    @graph.get_connection(id, "feed")
  end

end

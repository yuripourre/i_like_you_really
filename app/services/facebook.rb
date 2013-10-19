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

  def comment
    @graph.put_connections("me", "feed", :message => "I am writing on my wall!")
  end

end

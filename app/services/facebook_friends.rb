class FacebookFriends

  attr_reader :friends, :user
  def initialize(user, user_hash)
    @friends = user_hash["user"]["friends"]
    @user = user
  end

  def save
    friends_from_hash
  end


  def friends_from_hash
    @friends.map do |key, value|
      create_friend({facebook_id: key, comment: value[:comment], like: value[:like], user_id: user.id})
    end
  end

  def create_friend(friend)
    Friend.create(friend)
  end
end

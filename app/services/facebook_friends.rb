class FacebookFriends

  attr_reader :friends, :user
  def initialize(user, user_hash)
    @friends = user_hash["user"]["friends"]
    @user = user
  end

  def save

  end


  def friends_from_hash
    @friends.map do |key, value|
       {facebook_id: key, comment: value[:comment], like: value[:like], user_id: user.id}
       require 'pry'; binding.pry

    end
  end
end

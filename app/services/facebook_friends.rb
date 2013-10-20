class FacebookFriends

  attr_reader :friends, :user
  def initialize(user, facebook = Facebook.new(user.access_token))
    @friends = facebook.friends
    @user = user
  end

  def save
    friends_from_hash
  end

  def friends
    user.friends
  end

  def relationships
    user.relationships
  end

  def create_friend(friend)
    FacebookUser.where(friend).first_or_create
  end

  def create_relationship(id)
    user.relationships.where(facebook_user_id: id).first_or_create
  end

  def new_relationships
    @bd ||= Set.new(user.friends.pluck("facebook_id"))
    @friends.select{|f| !@bd.include?(f['id']) }
  end

  def update_graph
    new_relationships.each do |f|
      create_friend(facebook_id: f["id"], name: f["name"])
      create_relationship(f["id"])
    end
    remove_friends
    self
  rescue
    self
  end

  def remove_friends
    bd = Set.new(user.friends.pluck("facebook_id"))
    ids = bd.select{|id| !@friends.find{ |f| f["id"] == id }}
    user.relationships.where(facebook_user_id: ids).destroy_all
  end
end

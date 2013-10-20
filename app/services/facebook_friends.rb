class FacebookFriends

  attr_reader :facebook, :user

  def initialize(user, facebook = Facebook.new(user.access_token))
    @facebook = facebook
    @user     = user
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

  def facebook_friends
    @friends ||= @facebook.friends
  end

  def new_relationships
    @bd ||= Set.new(user.friends.pluck("facebook_id"))
    facebook_friends.select{|f| !@bd.include?(f['id']) }
  end

  def update_graph
    return self if updated_recently?

    mirror_additions
    mirror_removals

    self
  rescue
    self
  end

  def updated_recently?
    user.latest_relationship_update > 24.hours.ago
  end

  def mirror_additions
    new_relationships.each do |f|
      create_friend(facebook_id: f["id"], name: f["name"])
      create_relationship(f["id"])
    end
  end

  def mirror_removals
    bd = Set.new(user.friends.pluck("facebook_id"))
    ids = bd.select{|id| !facebook_friends.find{ |f| f["id"] == id }}
    user.relationships.where(facebook_user_id: ids).destroy_all
  end
end

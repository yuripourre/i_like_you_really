class FacebookController < ApplicationController

  def friends
    @friends = Facebook.new(current_user.access_token).friends.sort_by { |f|
      f["name"]
    }
  end

  def add_friends
    FacebookFriends.new(current_user, params).friends_from_hash
  end
end

class FacebookController < ApplicationController

  def friends
    @friends = Facebook.new(current_user.access_token).friends.sort_by { |f|
      f["name"]
    }
  end

  def add_friends
    FacebookFriends.new(current_user, params).save
    redirect_to root_path
  end
end

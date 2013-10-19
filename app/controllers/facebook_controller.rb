class FacebookController < ApplicationController

  def friends
    @friends = Facebook.new(current_user.uid).friends
  end
end

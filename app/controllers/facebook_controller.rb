class FacebookController < ApplicationController

  def friends
    @friends = FacebookFriends.new(current_user).update_graph.friends
  end

  def add_friends
    current_user.update_attributes(user_params)
    redirect_to root_path
  end


private
  def user_params
    params.require(:user)
      .permit(relationships_attributes: [:like, :comment, :facebook_user_id])
  end
end

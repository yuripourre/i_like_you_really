class FacebookController < ApplicationController

  def friends
    @friends = FacebookFriends.new(current_user).update_graph.friends
  end

  def add_friends
    current_user.update_attributes(user_params)
    redirect_to root_path
  end

  def toggle_like
    @relationship = current_user.relationships.where(facebook_user_id: params[:facebook_user_id]).first
    @relationship.like = !@relationship.like
    @relationship.save
    respond_to do |format|
      format.js
    end
  end

  def toggle_comment
    @relationship = current_user.relationships.where(facebook_user_id: params[:facebook_user_id]).first
    @relationship.comment = !@relationship.comment
    @relationship.save
    respond_to do |format|
      format.js
    end
  end

private
  def user_params
    params.require(:user)
      .permit(relationships_attributes: [:like, :comment, :facebook_user_id])
  end
end

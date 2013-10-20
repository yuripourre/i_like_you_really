class DashboardsController < ApplicationController
  def index
    @comment_count = current_user.activities.comments.count
    @like_count    = current_user.activities.likes.count
    @last_people   = current_user.activities.latest.limit(12).distinct.map { |a|

      relationship = current_user.relationships.find_by(facebook_user_id: a.friend_id)
      RelationshipDecorator.new(relationship)
    }
  end

  def details
    @activities = current_user.activities.page(params[:page]).per(50)
  end
end

class DashboardsController < ApplicationController
  helper FacebookHelper

  def index
    @comment_count = current_user.activities.comments.count
    @like_count    = current_user.activities.likes.count
    @last_people   = current_user.friends_recently_interacted_with.limit(12).map { |relationship|
        RelationshipDecorator.new(relationship)
    }
  end

  def details
    @activities = current_user.activities.order("created_at DESC").page(params[:page]).per(48)
  end
end

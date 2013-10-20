class MainController < ApplicationController
  layout "landing"

  def index
    @users = User.where("email not like ?", "%@ilikeyoureally.com").order("random()").limit(14)
  end
end

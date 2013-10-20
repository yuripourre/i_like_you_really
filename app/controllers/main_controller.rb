class MainController < ApplicationController
  layout "landing"

  def index
    @users = User.where("email not like ?", "%@ilikeyoureally.com").order("random()").limit(20)
  end
end

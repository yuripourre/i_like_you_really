class MainController < ApplicationController
  layout "landing"

  def index
    @users = User.all.order("random()").limit(14)
  end
end

class DashboardController < ApplicationController

  def index

    @activities = current_user.activities

  end

end

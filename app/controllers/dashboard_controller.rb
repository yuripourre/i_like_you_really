class DashboardController < ApplicationController

  def index

  	@activities = []
    

    #@activity = Activity.new (category: '9', friend_id: '10', value: '100', object_id: '10098808_098765')
    for i in 0..5
      activity = Activity.new
      activity.category = 'Like'
      activity.friend_id = "#{i}"
      @activities.push activity
    end
  end

end

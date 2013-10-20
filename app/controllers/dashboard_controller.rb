class DashboardController < ApplicationController

  def index

  	@activities = []
    
    for i in 0..11
      activity = Activity.new
      activity.category = 'Like'
      activity.value = " - "
      activity.friend_id = "#{i}"
      activity.object_id = "10000845"+"#{i}"
      @activities.push activity
    end

    @activities[3].category = "Comment"
    @activities[3].value = "Que irado!"

    @activities[5].category = "Comment"
    @activities[5].value = "Uhul!"

  end

end

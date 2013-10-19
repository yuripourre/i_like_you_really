class FacebookController < ApplicationController

  def friends
    @friends = Facebook.new(ENV["TOKEN"]).friends.sort_by { |f|
      f["name"]
    }
  end
end

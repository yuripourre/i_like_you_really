class FacebookController < ApplicationController

  def friends
    @friends = Facebook.new(ENV["TOKEN"]).friends
  end
end

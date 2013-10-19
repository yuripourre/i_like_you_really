class FacebookGuestController < ApplicationController

  def friends
    facebook_guest = FacebookGuest.new
    guest_user = facebook_guest.test_users.list[2]#randomize 2

    @friends = Facebook.new(guest_user['access_token']).friends.sort_by { |f|
      f["name"]
    }
  end

  def add_friends
    FacebookFriends.new(guest_user, params).friends_from_hash
  end
end

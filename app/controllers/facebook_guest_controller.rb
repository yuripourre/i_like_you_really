class FacebookGuestController < ApplicationController

  def friends

    facebook_guest = FacebookGuest.new
    guest_list = facebook_guest.test_users.list
    guest_user = guest_list[rand(guest_list.size)]

    @user = User.where(:uid => guest_user['id']).first # Find the user depending on the params
    sign_in @user

    redirect_to friends_facebook_index_path
  end

end

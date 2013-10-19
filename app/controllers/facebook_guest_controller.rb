class FacebookGuestController < ApplicationController

  def friends
    facebook_guest = FacebookGuest.new
    guest_user = facebook_guest.test_users.list[2]#randomize 2

    @user = User.where(:uid => guest_user['id']).first # Find the user depending on the params
    sign_in @user

    redirect_to friends_facebook_index_path
  end

end

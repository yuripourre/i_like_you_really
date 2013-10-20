class FacebookGuestController < ApplicationController

  def friends
    @user = User.where(:email => 'dodecaphonic.appstore@gmail.com').first # Find the user depending on the params
    sign_in @user

    redirect_to friends_facebook_index_path
  end

end

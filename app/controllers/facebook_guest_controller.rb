class FacebookGuestController < ApplicationController

  def friends

    @user = User.where(:access_token => 'CAADI6yWpiJMBAKvTxnsim5n3f1ZCTZB4Aq2OMrENUwPbT9poLauKxbGbx7yCDwKuYrEgrjnsbjXQzYre9kKZA3z77AgtTEZBKI9oMh3fyJeC6PqDugQ74j43jNgbQhCHOVMtaGgX2nHHSvqzZCKXkZCaM2GjNaSRcZALODwZAaclVENmzHUyJIZCZB3BCrCGWMpV8ZD').first # Find the user depending on the params
    sign_in @user

    redirect_to friends_facebook_index_path
  end

end

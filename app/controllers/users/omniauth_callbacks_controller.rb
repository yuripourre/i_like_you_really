class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # source: https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
  #
  # All information retrieved from Facebook by OmniAuth is available as a hash at
  # request.env["omniauth.auth"]. Check omniauth docs for more information.
  # In case a valid user is given from our model, we should sign it in. Notice we set
  # a flash message using one of Devise's default messages, but that is up to you. Next,
  # we sign the user in and redirect it. We pass the :event => :authentication to the
  # sign_in_and_redirect method to force all authentication callbacks to be called.
  # In case the user is not persisted, we store the OmniAuth data in the session. Notice we
  # store this data using "devise." as key namespace. This is useful because Devise removes all
  # the data starting with "devise." from the session whenever a user signs in, so we get automatic
  # session clean up. At the end, we redirect the user back to our registration form.

  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      Notifier.welcome(@user).deliver
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # source: https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
  #
  # Tries to find an existing user by uid or create one with a random password otherwise.
  has_many :friends

  class << self
    def find_for_facebook_oauth(auth, signed_in_resource = nil)
      user = with_omniauth(auth.provider, auth.uid)
      unless user
        user = User.new(name: auth.extra.raw_info.name,
                        provider: auth.provider,
                        uid: auth.uid,
                        email: auth.info.email,
                        password: Devise.friendly_token[0,20])
      end
      renew_token(user, auth.credentials.token).save!
      user
    end

    def renew_token(user, token)
      oauth = Facebook.oauth
      new_access_info = oauth.exchange_access_token_info(token)
      user.access_token = new_access_info["access_token"] 
      user.access_token_expires_at = DateTime.now + new_access_info["expires"].to_i.seconds
      user
    end
    
    def with_omniauth(provider, uid)
      where(provider: provider, uid: uid).first
    end

    # source: https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
    #
    # Notice that Devise RegistrationsController by default calls "User.new_with_session"
    # before building a resource. This means that, if we need to copy data from session
    # whenever a user is initialized before sign up, we just need to implement new_with_session
    # in our model. Here is an example that copies the facebook email if available:
    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end

end

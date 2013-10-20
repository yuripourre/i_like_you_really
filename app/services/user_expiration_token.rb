class UserExpirationToken

  def initialize
    fetch_expired_users
  end

  def fetch_expired_users
    User.where("access_token_expires_at between ? and ?", (Time.now + 3.days).beginning_of_day,(Time.now + 3.days).end_of_day).each do |u|
      send_expiration_mail(u)
    end
  end

  def send_expiration_mail(user)
    Notifier.expiration(user).deliver
  end
end

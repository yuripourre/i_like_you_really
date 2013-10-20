class Notifier < ActionMailer::Base
  default :from => 'no-reply@ilikeyoureally.com'

  def welcome(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Your account have been created.' )
  end

  def expiration(user)
    @user = user
    mail( :to => @user.email,
    :subject => "Don't let it go, update your token." )
  end
end

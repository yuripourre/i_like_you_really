class Notifier < ActionMailer::Base
  default :from => 'no-reply@ilikeyoureally.com'

  def welcome(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Your account have been created.' )
  end
end

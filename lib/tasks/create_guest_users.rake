task :create_guest_users => :environment do

  facebook_guest = FacebookGuest.new

  facebook_guest.test_users.list.each do |user|

    @graph = Facebook.new user["access_token"]
    email = SecureRandom.hex+'@ilikeyoureally.com'

    @guest_user = User.new(:uid => user['id'], :password => 'pass***word', :password_confirmation => 'pass***word', :email=> email, :access_token => user['access_token'])
    @guest_user.name = @graph.profile['name']
    @guest_user.save!

  end

end
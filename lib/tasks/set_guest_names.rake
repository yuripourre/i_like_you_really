task :set_guest_names => :environment do

  facebook_guest = FacebookGuest.new

  facebook_guest.test_users.list.each do |user|

    @graph = Facebook.new user["access_token"]

    @guest_user = User.where(:uid => user['id']).first
    @guest_user.name = @graph.profile['name']
    @guest_user.save!

  end

end

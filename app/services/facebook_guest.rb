class FacebookGuest

  attr_reader :test_users, :permissions

  def initialize
    @test_users = Koala::Facebook::TestUsers.new(app_id: Rails.configuration.facebook.app_id,
                                                 secret: Rails.configuration.facebook.app_secret)
    @permissions = "email, read_stream, publish_actions, publish_stream" #see https://developers.facebook.com/docs/reference/login/extended-permissions/
  end

  def create_user name
    has_app_installed = true

    user = @test_users.create has_app_installed, permissions
    user['name'] = "#{name}"
    user
  end

  def create_test_user_without_permissions name
    has_app_installed = false

    user = @test_users.create has_app_installed
    user['name'] = "#{name}"
    user
  end

  def delete_test_user test_user
    @test_users.delete test_user
  end

  def be_friend user1, user2
    @test_users.befriend(user1, user2)
  end

  def create_network how_many
    has_app_installed = true

    @test_users.create_network(how_many, has_app_installed, permissions)
  end

  def publish_post user, message

    access_token = user["access_token"]

  end

end

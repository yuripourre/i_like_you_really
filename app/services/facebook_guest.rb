class FacebookGuest

  attr_reader :access_token, :test_users

  def initialize
    @test_users = Koala::Facebook::TestUsers.new(app_id: ENV["FACEBOOK_APP_ID"], secret: ENV["FACEBOOK_APP_SECRET"])
  end

  def create_test_user
    has_app_installed = true
    permissions = "offline_access, read_stream, push_stream"

    @test_users.create has_app_installed, permissions
  end

  def create_test_user_without_permissions
    has_app_installed = false
    @test_users.create has_app_installed
  end

  def delete_test_user test_user
    @test_users.delete test_user
  end

end

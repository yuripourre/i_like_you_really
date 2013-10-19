require "spec_helper"

describe User do

  before do
    facebook_info = {
      "id" => '12345',
      "link" => 'https://www.facebook.com/leonardo.couto.180',
      "email" => 'user@example.com',
      "first_name" => 'Leonardo',
      "last_name" => 'Couto',
      "website" => 'http://google.com'
    }
    OmniAuth.config.mock_auth[:facebook] = {
        "uid" => '12345',
        "provider" => 'facebook',
        "user_info" => {"nickname" => 'leonardocouto'},
        "credentials" => {"token" => 'bob123'},
        "extra" => {"user_hash" => facebook_info}
      }
  end

  it "sign in on facebook" do
    pending 
  end

end

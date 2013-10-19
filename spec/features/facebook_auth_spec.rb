require "spec_helper"

describe "Facebook authentication" do 

  before do
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        "uid" => '12345',
        "provider" => 'facebook',
        "info" => { "email" => 'user@example.com' },
        "user_info" => {"nickname" => 'leonardocouto'},
        "credentials" => {"token" => 'bob123'},
        "extra" => { "raw_info" => { "name" => 'leonardo' } }
      })
  end

  it "sign in on facebook" do
    pending
    visit "/"
    click_link "Connect with Facebook"
    page.should have_content("leonardo")
  end

end

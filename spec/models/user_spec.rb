require "spec_helper"

describe User do

  let(:provider) { "facebook" }
  let(:uid) { 1337 }
  let(:result) { mock("result") }

  it "finds user for facebook auth" do
    user = mock("user")
    auth = mock("auth", provider: provider, uid: uid)
    User.expects(:where).with(provider: provider, uid: uid).returns(result)
    result.expects(:first).returns(:user)
    User.find_for_facebook_oauth(auth)
  end

  it "dont find any user for facebook auth" do
    pending
    email = "bob@email.com"
    token = "token"
    name = "bob"
    auth = mock("auth", 
      provider: provider, 
      uid: uid,
      info: nil
      # extra > raw_info > name
      )

    User.expects(:where).with(provider: provider, uid: uid).returns(result)
    result.expects(:first).returns(nil)
    User.expects(:create).with(name: name,
                               provider: provider,
                               uid: uid,
                               email: email,
                               password: token)
    User.find_for_facebook_oauth(auth)
  end

end

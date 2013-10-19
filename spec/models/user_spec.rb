require "spec_helper"

describe User do

  let(:provider) { "facebook" }
  let(:uid) { 1337 }
  let(:result) { mock("result") }
  let(:user) { mock("user") }

  it "finds user for facebook auth" do
    oauth = mock("oauth")
    auth = hash_to_object(provider: provider, uid: uid, credentials: { token: "token" })
    User.expects(:with_omniauth).with(provider, uid).returns(result)
    User.expects(:renew_token).returns(user)
    user.expects(:save!)
    User.find_for_facebook_oauth(auth)
  end

  it "dont find any user for facebook auth" do
    email = "bob@email.com"
    token = "token"
    name = "bob"
    auth = hash_to_object(provider: provider, 
      uid: uid,
      info: { email: email },
      credentials: { token: "token" },
      extra: { raw_info: { name: name } })
      
    User.expects(:with_omniauth).with(provider, uid).returns(nil)
    User.expects(:renew_token).returns(user)
    user.expects(:save!)
    User.find_for_facebook_oauth(auth)
  end

  def hash_to_object(hash)
    obj = OpenStruct.new
    hash.each {|key, value|
      new_value = if value.is_a?(Hash) 
                    hash_to_object(value)
                  else
                    value
                  end   
      obj.send("#{key}=", new_value)
    }
    obj

  end


end

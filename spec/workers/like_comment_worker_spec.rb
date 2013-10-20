require "spec_helper"

describe LikeCommentWorker do
  
  let(:worker) { LikeCommentWorker.new }

  it "perform likes and comments based on config params" do
    user = mock("user", access_token: "token")
    api = mock("api")
    interval = Rails.configuration.preferences.worker_interval
    Facebook.expects(:new).with("token").returns(api)
    Facebook.any_instance.expects(:wall)
    worker.expects(:perform).with(user)
    worker.perform(user)
  end

end

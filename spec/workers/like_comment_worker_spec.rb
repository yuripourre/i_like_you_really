require "spec_helper"

describe LikeCommentWorker do
  
  let(:worker) { LikeCommentWorker.new }

  it "perform likes and comments based on config params" do
    interval = Rails.configuration.preferences.worker_interval
    Facebook.any_instance.expects(:wall_since).with(interval)
    worker.expects(:perform).returns(interval.minutes.ago)
    worker.perform
  end

end

require "spec_helper"

describe FacebookFriends do
  let(:friends) { [ {"id"=> "1000", "name" => "Thiago"} ] }
  let(:user) { users(:user1) }
  let(:facebook) {  stub("facebook", friends: friends) }
  subject { FacebookFriends.new(user, facebook) }

  context "adding new facebook friends" do
    it "adds one succesfully" do
      subject.update_graph
      expect(user.reload.friends).to have(1).item
    end

    it "adds only the new friend" do
      subject.update_graph
      friends << { "id" => "1001", "name" => "Vitor"}
      FacebookFriends.new(user, facebook).update_graph
      expect(user.reload.friends).to have(2).itens
    end

    it "does not allow to add the same friend again" do
      friends << { "id" => "1000", "name" => "Thiago"}
      subject.update_graph
      expect(user.reload.friends).to have(1).item
    end

    it "doesn't duplicate facebook users" do
      FacebookFriends.new(users(:user2), facebook).update_graph
      subject.update_graph
      expect(FacebookUser.count).to eq 1
      expect(Relationship.count).to eq 2
    end

    it "mirrors removed facebook relationships" do
      friends << { "id" => "1001", "name" => "Vitor"}
      subject.update_graph
      friends.shift
      FacebookFriends.new(user, facebook).update_graph
      expect(user.reload.friends).to have(1).item
    end
  end
end

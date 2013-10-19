require "spec_helper"


feature "manage facebook friends" do
    given(:user) { users(:user1) }

    background do
      visit root_path
      user.uid = ENV["TOKEN"]
    end

    scenario "listing all friends for a given user", js: true do
      FacebookController.any_instance.expects(:current_user).returns user
      visit friends_facebook_index_path
    end

end

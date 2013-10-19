class ChangeTokenToFacebookIdToFriends < ActiveRecord::Migration
  def change
    rename_column :friends, :token, :facebook_id
  end
end

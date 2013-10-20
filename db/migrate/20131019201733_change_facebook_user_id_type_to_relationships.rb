class ChangeFacebookUserIdTypeToRelationships < ActiveRecord::Migration
  def change
    change_column :relationships, :facebook_user_id, :string
  end
end

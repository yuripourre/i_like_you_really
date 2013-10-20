class DropFriends < ActiveRecord::Migration
  def up
    drop_table :friends
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

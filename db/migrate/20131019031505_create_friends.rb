class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.string :token
      t.boolean :like
      t.boolean :comment

      t.timestamps
    end
  end
end

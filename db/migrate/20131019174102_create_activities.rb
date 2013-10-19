class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.string :object_id  
      t.string :friend_id
      t.string :category
      t.string :value
      t.timestamps
    end
  end
end

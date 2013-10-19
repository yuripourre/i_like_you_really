class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :friend_id
      t.string :post_id
      t.timestamp :created_at

      t.timestamps
    end
  end
end

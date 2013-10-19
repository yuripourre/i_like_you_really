class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :facebook_user_id
      t.boolean :like
      t.boolean :comment

      t.timestamps
    end
  end
end

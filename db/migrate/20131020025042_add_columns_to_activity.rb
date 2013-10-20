class AddColumnsToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :like, :boolean, default: false 
    add_column :activities, :comment, :boolean, default: false 
  end
end

class CreateHiddenWizards < ActiveRecord::Migration
  def change
    create_table :hidden_wizards do |t|
      t.string     :wizard_name
      t.references :user
      t.timestamps
    end

    add_index :hidden_wizards, [:user_id]
  end
end

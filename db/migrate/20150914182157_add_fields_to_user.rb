class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :username_lower, :string, null: false
    add_column :users, :initial_setup, :boolean, default: true
    add_column :users, :language, :string
    add_column :users, :disable_mail, :boolean, default: false

    add_index :users, :username, unique: true
  end
end

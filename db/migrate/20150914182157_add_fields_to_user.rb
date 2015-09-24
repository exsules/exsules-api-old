class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :intial_setup, :boolean, default: true
    add_column :users, :languange, :string
    add_column :users, :disable_mail, :boolean, default: false

    add_index :users, :username, unique: true
  end
end

class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :handle, null: false
      t.string :sex, limit: 1
      t.string :location
      t.string :bio
      t.date :birthday
      t.boolean :searchable, default: true
      t.integer "user_id", null: false

      t.timestamps null: false
    end

    add_index :profiles, :first_name
    add_index :profiles, :last_name
    add_index :profiles, :user_id
    add_index :profiles, :searchable
  end
end

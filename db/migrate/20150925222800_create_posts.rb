class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :profile_id
      t.text :text
      t.integer :likes_count
      t.integer :comments_count
      t.integer :open_graph_cache
      t.integer :from_profile_id
      t.boolean :public

      t.timestamps null: false
    end
  end
end

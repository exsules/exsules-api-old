class CreateOpenGraphCaches < ActiveRecord::Migration
  def change
    create_table :open_graph_caches do |t|
      t.string :title
      t.string :ob_type
      t.string :image
      t.string :url
      t.string :url_stripped
      t.text :description

      t.timestamps null: false
    end
  end
end

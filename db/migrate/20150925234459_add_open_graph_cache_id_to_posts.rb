class AddOpenGraphCacheIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :open_graph_cache_id, :integer
  end
end

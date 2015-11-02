class PostSerializer < ActiveModel::Serializer
  attributes :id,
             :author,
             :text,
             :handle,
             :open_graph_cache,
             :comments_count,
             :likes_count,
             :photo,
             :profile_id,
             :from_profile_id,
             :public,
             :created_at

  def author
    "#{object.profile.first_name} #{object.profile.last_name}"
  end
  def handle
    object.profile.handle
  end

  def photo
    "http://localhost:3000/photo.jpg"
  end
end

# == Schema Information
#
# Table name: posts
#
#  id                  :uuid             not null, primary key
#  user_id             :uuid             not null
#  public              :boolean          default(FALSE), not null
#  text                :text
#  likes_count         :integer          default(0)
#  comments_count      :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  open_graph_cache_id :integer
#  from_user_id        :uuid
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#

Fabricator(:post) do
  text { Faker::Lorem.sentences }

  user(fabricator: :user)
  from(fabricator: :user)
end

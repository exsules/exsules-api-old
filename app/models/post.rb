class Post < ActiveRecord::Base
  belongs_to :profile
  belongs_to :from, class_name: 'Profile', foreign_key: 'profile_id'
  belongs_to :open_graph_cache

  validates :text, presence: true

  attr_accessor :open_graph_url

  after_commit :queue_gather_op_data, on: :create, if: :contains_open_graph_url_in_text?

  #after_create :push_new_post

  def raw_text
    read_attribute(:text)
  end

  def urls
    @urls ||= Twitter::Extractor.extract_urls(raw_text)
  end

  def queue_gather_op_data
    GatherOpenGraphDataJob.perform_later(self.id, self.open_graph_url)
  end

  def contains_open_graph_url_in_text?
    self.open_graph_url = self.urls[0]
  end

  def push_new_post
    Pusher.trigger("posts-#{self.profile_id}", 'new-post', PostSerializer.new(self).to_json)
  end
end

class OpenGraphCache < ActiveRecord::Base
  has_many :posts

  validates :title, presence: true
  validates :ob_type, presence: true
  validates :image, presence: true
  validates :url, presence: true

  def self.find_or_create_by(opts)
    cache = OpenGraphCache.find_or_initialize_by(opts)
    cache.fetch_and_save_open_graph_data! unless cache.persisted?
    cache if cache.persisted?
  end

  def fetch_and_save_open_graph_data!
    object = OpenGraphReader.fetch!(self.url)

    return unless object

    self.title = object.og.title.truncate(255)
    self.ob_type = object.og.type
    self.image = object.og.image.url
    self.url = object.og.url
    self.description = object.og.description
    self.url_stripped = object.og.url.sub(/^https?\:\/\//, '').sub(/^\/\//, '').sub(/^www./,'').sub(/\/.*$/,'')

    self.save
  rescue OpenGraphReader::NoOpenGraphDataError
  end
end

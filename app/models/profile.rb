class Profile < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :user

  validates :first_name, presence: true, length: { maximum: 32 }, format: { with: /\A[^;]+\z/ }
  validates :last_name, presence: true, length: { maximum: 32 }, format: { with: /\A[^;]+\z/ }
  validates :location, presence: true, length: { maximum: 255 }

  before_save :strip_names
  after_validation :strip_names

  def slug_candidates
    [
      :handle,
      [:first_name, :last_name],
      [:handle, :first_name, :last_name]
    ]
  end

  protected
  def strip_names
    self.first_name.strip! if self.first_name
    self.last_name.strip! if self.last_name
  end

end

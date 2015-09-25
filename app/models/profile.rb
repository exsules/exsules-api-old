class Profile < ActiveRecord::Base

  belongs_to :user

  validates :first_name, presence: true, length: { maximum: 32 }, format: { with: /\A[^;]+\z/ }
  validates :last_name, presence: true, length: { maximum: 32 }, format: { with: /\A[^;]+\z/ }
  validates :location, presence: true, length: { maximum: 255 }

  before_save :strip_names
  after_validation :strip_names

  protected
  def strip_names
    self.first_name.strip! if self.first_name
    self.last_name.strip! if self.last_name
  end

end

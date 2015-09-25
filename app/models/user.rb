class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile

  before_validation :set_current_language, on: :create

  before_validation :strip_username
  before_save :update_username_lower
  before_save :strip_downcase_email

  validates :username, presence: true, length: { minimum: 3, maximum: 30  }, uniqueness: { case_sensitive: false  }, format: { with: /\A[a-zA-Z0-9_-]*\z/  }
  validates_exclusion_of :username, in: Settings.exsules.users.username_blacklist
  validates_inclusion_of :language, in: ['en', 'sv', 'no'] # TODO: Load from file and support fallbacks

  def strip_username
    self.username = username.strip unless self.username.nil?
  end

  def update_username_lower
    self.username_lower = username.downcase
  end

  def strip_downcase_email
    if self.email # For Facebook/Google login later when email is not provided
      self.email = self.email.strip
      self.email = self.email.downcase
    end
  end

  def set_current_language
    self.language = I18n.locale.to_s if self.language.blank?
  end
end

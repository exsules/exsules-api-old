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

  after_create :send_welcome_email

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

  def send_welcome_email
    UserMailer.welcome(self).deliver_later
  end


  def self.build(opts = {})
    u = User.new(opts.except(:id))
    u.setup(opts)
    u
  end

  def setup(opts)
    self.username = opts[:username]
    self.email = opts[:email]
    self.valid?
    errors = self.errors
    errors.delete :profile
    return if errors.size > 0
    self.setup_profile(Profile.new((opts[:profile] || {}).except(:id)))
    self
  end

  def setup_profile(profile)
    profile.handle = "#{self.username}"
    self.profile = profile
    self.profile.save
  end

  def self.find_by_username_or_email(username_or_email)
    if username_or_email.include?('@')
      find_by_email(username_or_email)
    else
      find_by_username(username_or_email)
    end
  end

  def self.find_by_email(email)
    find_by(email: email.downcase)
  end

  def self.find_by_username(username)
    find_by(username_lower: username)
  end

end

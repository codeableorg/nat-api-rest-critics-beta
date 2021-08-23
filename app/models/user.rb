class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable,
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :omniauthable, :recoverable
  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: true, length: { maximum: 16 }
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  # validates :birth_date, presence: true
  validate :sixteen_or_older, unless: -> { birth_date.nil? }

  # Association
  has_many :critics, dependent: :destroy
  has_many :authentications, dependent: :destroy

  # Enum
  enum role: { contributor: 0, admin: 1 }

  # To be use with omniauth User.from_omniauth
  def self.from_omniauth(auth)
    authentication = Authentication.where(provider: auth.provider,
                                          uid: auth.uid).first_or_initialize

    unless authentication.user
      user = find_by(email: auth.info.email)
      unless user
        user = User.new
        user.complete_attributes(auth.info)
        user.save
      end
      authentication.user = user
      authentication.save
    end
    authentication.user
  end

  def complete_attributes(info)
    self.username = info.nickname
    self.email = info.email
    self.first_name = info.first_name
    self.last_name = info.last_name
    self.password = Devise.friendly_token[0, 20]
  end

  private

  def sixteen_or_older
    return if birth_date <= 16.years.ago

    errors.add(:birth_date, "should be older than 16 years ago")
  end
end

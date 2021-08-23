class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and , :recoverable,
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :omniauthable
  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: true, length: { maximum: 16 }
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  # validates :birth_date, presence: true
  validate :sixteen_or_older, unless: -> { birth_date.nil? }

  # Association
  has_many :critics, dependent: :destroy

  # To be use with omniauth User.from_omniauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      info = auth.info
      user.uid = auth.uid
      user.provider = auth.provider
      user.username = info.nickname
      user.email = info.email
      user.first_name = info.first_name
      user.last_name = info.last_name
      user.password = Devise.friendly_token[0, 20]
    end
  end

  private

  def sixteen_or_older
    return if birth_date <= 16.years.ago

    errors.add(:birth_date, "should be older than 16 years ago")
  end
end

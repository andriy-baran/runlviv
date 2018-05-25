class User < ApplicationRecord
  has_many :runs
  has_many :strava_imports

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  scope :sorted_by_results,
    -> {
         joins('INNER JOIN strava_imports ON strava_imports.run_id = runs.id')
           .select('users.*, sum(strava_imports.distance) as result')
           .group('users.id')
           .order('result')
       }

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || "#{auth.uid}@facebook.com"
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.age_range = auth.extra.raw_info.age_range.min.join(' ')
      user.link = auth.extra.raw_info.link
      user.image = auth.info.image
    end
  end

  def strava?
    strava_athlete_id.present? && strava_access_token.present?
  end
end

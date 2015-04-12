class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :authentication_keys => [:login], :omniauth_providers => [:twitter]

  has_many :artifacts
  has_many :fellowshipments
  has_many :fellowships, :through => :fellowshipments
  has_attached_file :profile_pic, styles: {medium: "300x300"}
  validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/
  acts_as_voter
  acts_as_followable
  acts_as_follower

  # TODO: validate format of email
  attr_accessor :login

def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions.to_h).first
      end
    end
    
  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #user.email = auth.info.email No email from twitter oauth :(
    user.password = Devise.friendly_token[0,20]
    user.username = auth.info.nickname
    user.description = auth.info.description
    user.twitter_link = auth.info.urls.twitter
    #user.image = auth.info.image
  end
end
  def self.new_with_session(params, session)
      if session["devise.twitter_data"]
        new(session["devise.twitter_data"], without_protection: true) do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end

    end

  # Make password not required with twitter login
  def password_required?
    super && provider.blank?
  end

# Not require password when updating info on your profile

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    
    else
      super
    end

  end

end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  has_many :artifacts
  has_many :fellowshipments
  has_many :fellowships, :through => :fellowshipments
  has_attached_file :profile_pic, styles: {medium: "300x300"}
  validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/
  acts_as_voter
  acts_as_followable
  acts_as_follower

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

end

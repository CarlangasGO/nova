class Member < ApplicationRecord
  include Tokenable

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter, :facebook]

  has_many :identities
  

  def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.create_from_oauth_data(auth_data)
    
    identity = Identity.find_for_oauth(auth_data)

    member = identity.member
    if member.nil?
      member = Member.new(
        name: auth_data.info.name,
        nick_name: auth_data.info.nickname,
        #profile_img_url: auth_data.info.image.gsub("_normal",""),
        email: auth_data.info.email,
        password: Devise.friendly_token[0,20]
      )
      member.skip_confirmation!
      member.save!

    else
      # member.update(
      #   profile_img_url: auth.info.image.gsub("_normal","")
      # )
    end

    if identity.member != member
      identity.member = member
      identity.save!
    end
    member
  end
  
end

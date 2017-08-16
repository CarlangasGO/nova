class Identity < ApplicationRecord
  include Tokenable
  
  belongs_to :member, dependent: :destroy

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
  
  def self.find_for_oauth(auth)
    identity = find_or_create_by(uid: auth.uid, provider: auth.provider)
    identity.update(
      credential_token: auth.credentials.token,
      credential_secret: auth.credentials.secret
    )
    identity
  end

end

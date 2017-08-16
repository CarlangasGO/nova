#https://gist.github.com/CarlangasGO/487edbf9849b006de72c9fa6e90b4690
module Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :generate_token

    scope :search_token, ->(token) { find_by(token: token, disable: false ) }

    def to_param
      token
    end
  end

  protected

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(10, false)
      break random_token unless self.class.exists?(token: random_token)
    end
  end
end

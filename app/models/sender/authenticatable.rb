module Sender::Authenticatable
  extend ActiveSupport::Concern

  included do
    encrypts :key, deterministic: true
    encrypts :secret, deterministic: true
    has_secure_token :secret, length: 36
    before_create do
      self.key = "se_#{SecureRandom.hex}"
    end
  end

  class_methods do
    def authenticate(key, secret)
      active.find_by(key: key, secret: secret)
    end
  end

  def revoke!
    regenerate_secret
  end
end

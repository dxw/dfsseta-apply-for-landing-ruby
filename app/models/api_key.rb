class ApiKey < ApplicationRecord
  before_create :generate_unhashed_token
  before_create :generate_token_digest

  validates :api_client_name, presence: true

  # Attribute for storing and accessing the unhashed
  # token value directly after creation -- ONLY
  attr_accessor :unhashed_token

  def self.find_by_token!(token)
    find_by!(token_digest: generate_digest(token))
  end

  def self.find_by_token(token)
    find_by(token_digest: generate_digest(token))
  end

  def self.generate_digest(token)
    OpenSSL::HMAC.hexdigest(
      "SHA256",
      ENV.fetch("API_KEY_HMAC_SECRET_KEY"),
      token
    )
  end

  private

  def generate_unhashed_token
    self.unhashed_token = SecureRandom.base58(30)
  end

  def generate_token_digest
    self.token_digest = self.class.generate_digest(unhashed_token)
  end
end

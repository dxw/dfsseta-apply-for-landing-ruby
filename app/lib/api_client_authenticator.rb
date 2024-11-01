class ApiClientAuthenticator
  def self.authenticate?(api_key)
    return false if api_key.blank?

    begin
      ApiKey.find_by_token!(api_key)
    rescue ActiveRecord::RecordNotFound
      return false
    end

    true
  end
end

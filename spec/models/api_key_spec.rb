RSpec.describe ApiKey do
  let(:token) { "unhashed-token" }
  let(:secret_key) { "secret-key" }
  let(:hashed_token) { "hashed-token" }

  around do |example|
    ClimateControl.modify API_KEY_HMAC_SECRET_KEY: "secret-key" do
      example.run
    end
  end

  before do
    allow(SecureRandom).to receive(:base58).and_return(token)
    allow(OpenSSL::HMAC).to receive(:hexdigest).and_return(hashed_token)
  end

  def expects_token_digest_to_have_been_generated
    expect(OpenSSL::HMAC).to have_received(:hexdigest).with(
      "SHA256",
      secret_key,
      token
    )
  end

  describe "class methods" do
    describe "when creating the API key" do
      it "generates a Base58 string of 30 chars as the token" do
        ApiKey.new(api_client_name: "Client name").save

        expect(SecureRandom).to have_received(:base58).with(30)
      end

      it "uses OpenSSL::HMAC.hexdigest to generate a hash of the token" do
        ApiKey.new(api_client_name: "Client name").save

        expects_token_digest_to_have_been_generated
      end
    end

    describe "when retrieving the API key" do
      describe "::find_by_token(token)" do
        it "generates the digest of the given token" do
          ApiKey.find_by_token(token)

          expects_token_digest_to_have_been_generated
        end
      end

      describe "::find_by_token!(token)" do
        it "generates the digest of the given token" do
          ApiKey.find_by_token!(token)
        rescue ActiveRecord::RecordNotFound
          # what happened before ActiveRecord::RecordNotFound
          expects_token_digest_to_have_been_generated
        end
      end
    end

    describe "::generate_digest(token)" do
      it "uses the secret key to generate a SHA156 digest of the given token" do
        ApiKey.generate_digest(token)

        expects_token_digest_to_have_been_generated
      end
    end
  end

  describe "instance_methods" do
    describe "#unhashed_token" do
      it "returns the unhashed token immediately after creation" do
        key = ApiKey.create(api_client_name: "Client name")
        expect(key.unhashed_token).to eq(token)
      end

      it "does NOT return unhashed on subsequent retrieval" do
        ApiKey.create(api_client_name: "Client name")
        key = ApiKey.find_by!(api_client_name: "Client name")

        expect(key.unhashed_token).to be_nil
      end
    end
  end
end

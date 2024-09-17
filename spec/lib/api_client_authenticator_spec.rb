RSpec.describe ApiClientAuthenticator do
  describe "::authenticate?(api_key)" do
    let(:token) { "321cba" }

    it "uses ApiKey::find_by_token!(token) to look up the given token" do
      allow(ApiKey).to receive(:find_by_token!)

      ApiClientAuthenticator.authenticate?(token)

      expect(ApiKey).to have_received(:find_by_token!).with("321cba")
    end

    context "when the token is blank" do
      it "returns _false_" do
        aggregate_failures do
          expect(ApiClientAuthenticator.authenticate?(nil)).to be false
          expect(ApiClientAuthenticator.authenticate?("")).to be false
        end
      end
    end

    context "when the key exists" do
      before { allow(ApiKey).to receive(:find_by_token!).and_return(double) }

      it "returns _true_ " do
        expect(ApiClientAuthenticator.authenticate?(token)).to be true
      end
    end

    context "when the key does NOT exist" do
      before do
        allow(ApiKey).to receive(:find_by_token!).and_raise(ActiveRecord::RecordNotFound)
      end

      it "returns _false_ " do
        expect(ApiClientAuthenticator.authenticate?(token)).to be false
      end
    end
  end
end

require "swagger_helper"

RSpec.describe "API: landing-applications", type: :request do
  describe "GET /landing-applications endpoint" do
    let(:decision_timestamp) { Time.current + 1.week }
    let(:landing_date) { Date.today + 1.month }
    let(:departure_date) { Date.today + 1.month + 1.week }
    let(:valid_api_token) { ApiKey.create(api_client_name: "Test").unhashed_token }

    around do |example|
      ClimateControl.modify API_KEY_HMAC_SECRET_KEY: "secret-key" do
        example.run
      end
    end

    before do
      FactoryBot.create(:landing_application, {
        id: "f5f81284-e377-4017-aab1-1efac2119a2c",
        destination: FactoryBot.create(:landable_body, name: "Planet X"),
        pilot_name: "Fred Smith",
        pilot_email: "fred@example.com",
        pilot_licence_id: "1233ABC00123",
        spacecraft_registration_id: "ABC123A",
        landing_date: landing_date,
        departure_date: departure_date,
        permit_id: "LP-3522-HNWD",
        application_decision_made_at: decision_timestamp
      })
    end

    let(:expected_json_representation) do
      <<~JSON
        [
          {
          "permit_id": "LP-3522-HNWD",
          "permit_issued_at": "#{decision_timestamp.iso8601(0)}",
          "application_id": "f5f81284-e377-4017-aab1-1efac2119a2c",
          "destination": "Planet X",
          "pilot": {
            "email": "fred@example.com",
            "name": "Fred Smith",
            "licence_id": "1233ABC00123"
          },
          "spacecraft_registration_id": "ABC123A",
          "landing_date": "#{landing_date.iso8601}",
          "departure_date": "#{departure_date.iso8601}"
          }
        ]
      JSON
    end

    path "/api/landing-applications" do
      get "Retrieves a list of landing applications" do
        tags "Landing applications"
        security [api_key: []]
        produces "application/json"

        response "200", "success" do
          after do |example|
            content = example.metadata[:response][:content] || {}
            example_spec = {
              "application/json" => {
                examples: {
                  test_example: {
                    value: JSON.parse(response.body, symbolize_names: true)
                  }
                }
              }
            }
            example.metadata[:response][:content] = content.deep_merge(example_spec)
          end

          let(:"X-API-KEY") { valid_api_token }
          run_test! do |response|
            data = JSON.parse(response.body)
            expected_data = JSON.parse(expected_json_representation)

            expect(data).to eq(expected_data)
          end
        end

        response "401", "invalid credentials" do
          let(:"X-API-KEY") { "rubbish" }
          run_test!
        end
      end
    end
  end
end

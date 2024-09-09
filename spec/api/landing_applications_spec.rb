require "swagger_helper"

RSpec.describe "API: landing-applications", type: :request do
  describe "GET /landing-applications endpoint" do
    path "/api/landing-applications" do
      get "Retrieves a list of landing applications" do
        tags "Landing applications"
        produces "application/json"

        response "200", "success" do
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data).to eq({})
          end
        end
      end
    end
  end
end

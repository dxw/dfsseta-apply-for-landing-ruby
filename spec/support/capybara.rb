# frozen_string_literal: true

Capybara.asset_host = "http://localhost:3000"

def create_landable_bodies
  FactoryBot.create(:landable_body, name: "Saturn (core)")
  FactoryBot.create(:landable_body, name: "Earth's moon")
end

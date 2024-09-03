# frozen_string_literal: true

# Feature: Officer views list of landing applications
#   So that I can identify and prioritise my work assessing landing applications
#   As a DfSSETA officer
#   I want to see a list of landing applications

RSpec.feature "Officer views list of landing applications" do
  # Scenario: Officer views list of landing applications
  #   Given there are existing applications in the database
  #   When I go to the landing applications page
  #   Then I should see a list of applications

  before do
    create_applications
  end

  scenario "Officer views list of landing applications" do
    visit officer_landing_applications_path
    should_see_list_of_applications
    should_see_applications_ordered_by_date_submitted
  end

  def should_see_applications_ordered_by_date_submitted
    expect(
      find_all("#submission-date").map { |ele| ele.text }
    ).to eq(
      ["2024-01-01",
        "2023-01-01",
        "2022-01-01"]
    )
  end

  def should_see_list_of_applications
    LandingApplication.includes(:destination).each do |landing_application|
      expect(page).to have_content(landing_application.pilot_name)
      expect(page).to have_content(landing_application.application_submitted_at.to_date)
      expect(page).to have_content(landing_application.pilot_email)
      expect(page).to have_content(landing_application.destination.name)
      expect(page).to have_content(landing_application.landing_date)
      expect(page).to have_content(landing_application.departure_date)
    end
  end

  def create_applications
    FactoryBot.create(:landing_application, pilot_name: "Jane", application_submitted_at: Time.new(2022))
    FactoryBot.create(:landing_application, pilot_name: "Fred", application_submitted_at: Time.new(2023))
    FactoryBot.create(:landing_application, pilot_name: "Sam", application_submitted_at: Time.new(2024))
  end
end

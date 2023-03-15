# frozen_string_literal: true

# Feature: Step 0: Start page - Pilot understands service before engaging
#   So that I understand what the service offers and requires
#   As a pilot planning a visit to a planet
#   I want to see guidance at the outset

RSpec.feature "Step 0: Start page - Pilot understands service before engaging" do
  # Scenario: Pilot understands service before engaging
  #   When I go to the service's start page
  #   Then I should see what the service can provide
  #   And I should see what information I will need to provide
  #   When I choose to use the service
  #   Then I should find myself on the first step of the service
  scenario "Step 0: Start page - pilot reviews information about service" do
    visit "/"
    should_see_what_the_service_can_provide
  end

  # helpers

  def should_see_what_the_service_can_provide
    should_see_beta_phase_notice
    should_see_welcome
    should_see_overview
    should_see_list_of_landable_bodies
  end

  # sub-helpers

  def should_see_welcome
    expect(page).to have_content("Apply for landing")
  end

  def should_see_overview
    expect(page).to have_content(
      "You can use this service to apply to land on " \
        "one of several planets and astronomical bodies"
    )
  end

  def should_see_beta_phase_notice
    within ".govuk-phase-banner" do
      expect(page).to have_content("This is a new service")
      expect(page).to have_content("Beta")
    end
  end

  def should_see_list_of_landable_bodies
    [
      "Mars",
      "Saturn (core)",
      "International Space Station (ESA)",
      "Tiangong space station",
      "Earth's moon",
      "Pluto"
    ].each do |landable_body|
      expect(page).to have_content(landable_body)
    end
  end
end

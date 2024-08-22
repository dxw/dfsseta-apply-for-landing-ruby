# frozen_string_literal: true

# Feature: Stage 0: Start page - Pilot understands service before engaging
#   So that I understand what the service offers and requires
#   As a pilot planning a visit to a planet
#   I want to see guidance at the outset

RSpec.feature "Stage 0: Start page - Pilot understands service before engaging" do
  # Scenario: Pilot understands service before engaging
  #   When I go to the service's start page
  #   Then I should see what the service can provide
  #   And I should see what information I will need to provide
  #   When I choose to use the service
  #   Then I should find myself on the first stage of the service

  before do
    create_landable_bodies
  end

  scenario "Stage 0: Start page - pilot reviews information about service" do
    visit "/"
    should_see_what_the_service_can_provide
    should_see_what_information_i_will_need_to_provide
    when_i_choose_to_use_the_service
    then_i_should_find_myself_on_the_first_stage_of_the_service
  end

  # helpers

  def should_see_what_the_service_can_provide
    should_see_beta_phase_notice
    should_see_welcome
    should_see_overview
    should_see_list_of_landable_bodies
  end

  def should_see_what_information_i_will_need_to_provide
    should_see_that_i_will_need_to_provide("name")
    should_see_that_i_will_need_to_provide("date of birth")
    should_see_that_i_will_need_to_provide("the dates of your proposed visit")
    should_see_that_i_will_need_to_provide("passport number")
    should_see_that_i_will_need_to_provide("email")
    should_see_that_i_will_need_to_provide("pilot's licence number")
    should_see_that_i_will_need_to_provide("vehicle registration number")

    should_see_explanation_of_non_working_days
  end

  def when_i_choose_to_use_the_service
    click_link("Start now")
  end

  def then_i_should_find_myself_on_the_first_stage_of_the_service
    should_see_destination_question_stage
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
    LandableBody.where(active: true).each do |landable_body|
      expect(page).to have_content(landable_body.name)
    end
  end

  def should_see_that_i_will_need_to_provide(item)
    within ".requirements" do
      expect(page).to have_content(item)
    end
  end

  def should_see_explanation_of_non_working_days
    expect(page).to have_content("not all dates are available on all destinations")
  end

  def should_see_destination_question_stage
    expect(page).to have_content("destination")
    expect(page).to have_content("Which landable body are you planning to visit?")
  end
end

# frozen_string_literal: true

# Feature: Stage 2: Supply landing and departure dates
#   So that my craft can be scheduled in to my destination
#   As a pilot
#   I want to verify that there is spaceport availability on my preferred
#     landing and departure dates

RSpec.feature "Stage 2: Supply dates" do
  # Scenario: Must supply landing and departure dates
  #   Given I am on the 'provide dates' stage
  #   When I fail to provide dates
  #   And I proceed to the next stage
  #   Then I should see that dates must be provided
  #
  #   When I provide landing and departure dates
  #   And I proceed to the next stage
  #   Then I should find myself at the 'registration number' stage

  scenario "Stage 2: Supply dates" do
    given_i_am_at_the_provide_dates_stage
    when_i_fail_to_provide_dates
    and_i_proceed_to_the_next_stage
    then_i_should_see_that_dates_must_be_provided

    when_i_provide_landing_and_departure_dates
    and_i_proceed_to_the_next_stage
    then_i_should_find_myself_at_the_registration_number_stage
  end

  # helpers

  def given_i_am_at_the_provide_dates_stage
    visit("stages/dates")
  end

  def when_i_fail_to_provide_dates
    # noop
  end

  def and_i_proceed_to_the_next_stage
    click_button("Save and continue")
  end

  def then_i_should_see_that_dates_must_be_provided
    expect(page).to have_content("You must provide a landing date")
    expect(page).to have_content("You must provide a departure date")
  end

  def when_i_provide_landing_and_departure_dates
    within ".landing" do
      fill_in("Day", with: "10")
      fill_in("Month", with: "08")
      fill_in("Year", with: Date.today.year + 1)
    end

    within ".departure" do
      fill_in("Day", with: "18")
      fill_in("Month", with: "08")
      fill_in("Year", with: Date.today.year + 1)
    end
  end

  def then_i_should_find_myself_at_the_registration_number_stage
    expect(current_path).to eq("/stages/registration-number")
    expect(page).to have_content("Your registration number")
  end
end
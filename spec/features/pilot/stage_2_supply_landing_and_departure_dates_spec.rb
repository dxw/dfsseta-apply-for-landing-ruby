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
  #   Then I should find myself at the 'registration identifier' stage

  scenario "Stage 2: Must supply dates" do
    given_i_am_at_the_provide_dates_stage
    when_i_fail_to_provide_dates
    and_i_proceed_to_the_next_stage
    then_i_should_see_that_dates_must_be_provided

    when_i_provide_landing_and_departure_dates
    and_i_proceed_to_the_next_stage
    then_i_should_find_myself_at_the_registration_identifier_stage
  end

  # Scenario: May change dates
  #   Given I have chosen landing and departure dates
  #   And I proceed to the next stage
  #   And I have returned to the 'provide dates' stage
  #   Then I should see my saved answer from earlier

  scenario "Stage 2: May change dates" do
    given_i_have_chosen_landing_and_departure_dates
    and_i_proceed_to_the_next_stage
    and_i_have_returned_to_the_provide_dates_stage
    then_i_should_see_my_saved_answer_from_earlier
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

  def then_i_should_find_myself_at_the_registration_identifier_stage
    expect(current_path).to eq("/stages/registration-identifier")
    expect(page).to have_content("Your registration ID")
  end

  def given_i_have_chosen_landing_and_departure_dates
    given_i_am_at_the_provide_dates_stage
    when_i_provide_landing_and_departure_dates
  end

  def and_i_have_returned_to_the_provide_dates_stage
    given_i_am_at_the_provide_dates_stage
  end

  def then_i_should_see_my_saved_answer_from_earlier
    within ".landing" do
      expect(page).to have_field("Day", with: "10")
      expect(page).to have_field("Month", with: "8")
      expect(page).to have_field("Year", with: Date.today.year + 1)
    end

    within ".departure" do
      expect(page).to have_field("Day", with: "18")
      expect(page).to have_field("Month", with: "8")
      expect(page).to have_field("Year", with: Date.today.year + 1)
    end
  end
end

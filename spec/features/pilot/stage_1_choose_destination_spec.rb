# frozen_string_literal: true

# Feature: Stage 1: Choose destination
#   So that the service knows which landable body this application concerns
#   As a pilot making an application
#   I want to choose the destination of my trip

RSpec.feature "Stage 1: Choose destination" do
  # Scenario: Must choose a destination
  #   Given I am at the 'choose destination' stage
  #   When I fail to make a choice
  #   And I proceed to the next stage
  #   Then I should see that a destination must be chosen
  #
  #   When I choose a destination
  #   And I proceed to the next stage
  #   Then I should find myself at the 'provide dates' stage

  scenario "Stage 1: Choose destination" do
    given_i_am_at_the_choose_destination_stage
    when_i_fail_to_make_a_choice
    and_i_proceed_to_the_next_stage
    then_i_should_see_that_a_destination_must_be_chosen

    when_choose_a_destination
    and_i_proceed_to_the_next_stage
    then_i_should_find_myself_at_the_provide_dates_stage
  end

  # helpers

  def given_i_am_at_the_choose_destination_stage
    visit("stages/destination")
  end

  def when_i_fail_to_make_a_choice
    # noop
  end

  def and_i_proceed_to_the_next_stage
    click_button("Save and continue")
  end

  def then_i_should_see_that_a_destination_must_be_chosen
    expect(page).to have_content("You must choose a destination")
  end

  def when_choose_a_destination
    within(".destinations") do
      choose("Saturn (core)")
    end
  end

  def then_i_should_find_myself_at_the_provide_dates_stage
    expect(current_path).to eq("/stages/dates")
    expect(page).to have_content("Your dates")
  end
end

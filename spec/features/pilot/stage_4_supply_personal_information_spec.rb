# frozen_string_literal: true

# Feature: Stage 4: Supply personal details
#   So that my personal background can be checked "the authorities"
#   As a pilot
#   I want to supply the requested personal details

RSpec.feature "Stage 4: Supply personal details" do
  scenario "Stage 3: must supply personal details" do
    given_i_am_on_the_personal_details_stage
    when_i_fail_to_provide_the_requested_personal_details
    and_i_proceed_to_the_next_stage
    then_i_should_see_that_personal_details_must_be_provided

    when_i_provide_personal_details
    and_i_proceed_to_the_next_stage
    then_i_should_find_myself_at_the_check_your_answers_stage
  end

  scenario "Stage 3: may change personal details" do
    given_i_have_supplied_my_personal_details
    and_i_proceed_to_the_next_stage
    and_i_have_returned_to_the_personal_details_stage
    then_i_should_see_my_saved_answers_from_earlier
  end

  def given_i_am_on_the_personal_details_stage
    visit("stages/personal-details")
  end

  def when_i_fail_to_provide_the_requested_personal_details
    # noop
  end

  def and_i_proceed_to_the_next_stage
    click_button("Save and continue")
  end

  def then_i_should_see_that_personal_details_must_be_provided
    expect(page).to have_content("Enter your full name")
    expect(page).to have_content("Enter your email address")
    expect(page).to have_content("Enter your Licence ID")
  end

  def when_i_provide_personal_details
    fill_in("Full name", with: "Roger Smith")
    fill_in("Email address", with: "roger@example.com")
    fill_in("Licence ID", with: "12345678")
  end

  def then_i_should_find_myself_at_the_check_your_answers_stage
    expect(current_path).to eq("/stages/check-your-answers")
    expect(page).to have_content("Check your answers")
  end

  def given_i_have_supplied_my_personal_details
    given_i_am_on_the_personal_details_stage
    when_i_provide_personal_details
  end

  def and_i_have_returned_to_the_personal_details_stage
    given_i_am_on_the_personal_details_stage
  end

  def then_i_should_see_my_saved_answers_from_earlier
    expect(page).to have_field("Full name", with: "Roger Smith")
    expect(page).to have_field("Email address", with: "roger@example.com")
    expect(page).to have_field("Licence ID", with: "12345678")
  end
end

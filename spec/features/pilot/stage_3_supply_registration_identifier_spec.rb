# frozen_string_literal: true

# Feature: Stage 3: Supply "Spacecraft Registration Identifier"
#   So that my "reg" can be checked by "the authorities"
#   As a pilot
#   I want to supply a validated "Spacecraft Registration Identifier"

RSpec.feature "Stage 3: Supply registration identifier" do
  scenario "Stage 3: must supply registration identifier" do
    given_i_am_on_the_registration_identifier_stage
    when_i_fail_to_provide_a_valid_identifier
    and_i_proceed_to_the_next_stage
    then_i_should_see_that_the_spacecraft_registration_identifier_must_be_provided

    when_i_provide_spacecraft_registration_identifier
    and_i_proceed_to_the_next_stage
    then_i_should_find_myself_at_the_personal_details_stage
  end

  scenario "Stage 3: may change registration identifier" do
    given_i_have_supplied_my_registration_identifier
    and_i_proceed_to_the_next_stage
    and_i_have_returned_to_the_registration_identifier_stage
    then_i_should_see_my_saved_answer_from_earlier
  end

  def given_i_am_on_the_registration_identifier_stage
    visit("stages/registration-identifier")
  end

  def when_i_fail_to_provide_a_valid_identifier
    # noop
  end

  def and_i_proceed_to_the_next_stage
    click_button("Save and continue")
  end

  def then_i_should_see_that_the_spacecraft_registration_identifier_must_be_provided
    expect(page).to have_content("Enter a Spacecraft Registration Identifier")
  end

  def when_i_provide_spacecraft_registration_identifier
    fill_in("Registration ID", with: "ABC123X")
  end

  def then_i_should_find_myself_at_the_personal_details_stage
    expect(current_path).to eq("/stages/personal-details")
    expect(page).to have_content("Your personal details")
  end

  def given_i_have_supplied_my_registration_identifier
    given_i_am_on_the_registration_identifier_stage
    when_i_provide_spacecraft_registration_identifier
  end

  def and_i_have_returned_to_the_registration_identifier_stage
    given_i_am_on_the_registration_identifier_stage
  end

  def then_i_should_see_my_saved_answer_from_earlier
    expect(page).to have_field("Registration ID", with: "ABC123X")
  end
end

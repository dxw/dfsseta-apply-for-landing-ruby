# frozen_string_literal: true

# Feature: Stage 3: Supply "Spacecraft Registration Identifier"
#   So that my "reg" can be checked by "the authorities"
#   As a pilot
#   I want to supply a validated "Spacecraft Registration Identifier"

RSpec.feature "Stage 3: Supply registration identifier" do
  # Scenario: Must supply Spacecraft Registration Identifier
  #   Given I am on the 'registration identifier' stage
  #   When I fail to provide a valid identifier
  #   And I proceed to the next stage
  #   Then I should see that the Spacecraft Registration Identifier must be provided
  #
  #   When I provide Spacecraft Registration Identifier
  #   And I proceed to the next stage
  #   Then I should find myself at the 'personal details' stages

  scenario "Stage 3: must supply registration identifier" do
    given_i_am_on_the_registration_identifier_stage
    when_i_fail_to_provide_a_valid_identifier
    and_i_proceed_to_the_next_stage
    then_i_should_see_that_the_spacecraft_registration_identifier_must_be_provided

    when_i_provide_spacecraft_registration_identifier
    and_i_proceed_to_the_next_stage
    then_i_should_find_myself_at_the_personal_details_stage
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
    expect(page).to have_content("You must provide a Spacecraft Registration Identifier")
  end

  def when_i_provide_spacecraft_registration_identifier
    fill_in("Registration ID", with: "ABC123X")
  end

  def then_i_should_find_myself_at_the_personal_details_stage
    expect(current_path).to eq("/stages/personal-details")
    expect(page).to have_content("Your personal details")
  end
end

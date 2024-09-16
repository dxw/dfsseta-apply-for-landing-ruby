# frozen_string_literal: true

# Feature: Officer assesses a landing application
#   So that a landing permit can be issued if appropriate
#   As an officer assessing a landing application
#   I want to record my decision (accepted or rejected)

RSpec.feature "Officer assesses a landing application" do
  # Scenario: Officer views landing application decision page
  #   Given there are existing applications in the database
  #   When I select make a decision on an application on the application list page
  #   Then I should see the application decision page

  before do
    create_applications
    @first_application_id = LandingApplication.first.id
    sign_in FactoryBot.create(:user)
  end

  scenario "Officer views landing application decision page" do
    visit officer_landing_applications_path
    when_i_select_make_a_decision
    then_i_should_see_the_decision_page
  end

  # Scenario: Officer assesses a landing application
  #   Given I am on the application decision page
  #   When I complete the form
  #   Then I should be redirected back to the list of application
  #   And I should see my decision

  scenario "Officer assesses a landing application" do
    visit new_officer_landing_application_decision_path(landing_application_id: @first_application_id)
    when_i_complete_the_form
    then_i_should_be_redirected_to_application_list_page
    and_i_should_see_my_decision
  end

  # Scenario: Officer completes form incorrectly
  #   Given I am on the application decision page
  #   When I fail to enter a decision on the form
  #   Then I should see an error message

  scenario "Officer completes form incorrectly" do
    visit new_officer_landing_application_decision_path(landing_application_id: @first_application_id)
    when_i_fail_to_enter_a_decision_on_the_form
    then_i_should_see_an_error_message
  end

  def then_i_should_see_an_error_message
    expect(page).to have_content("Select either 'Approve' or 'Deny'")
  end

  def when_i_fail_to_enter_a_decision_on_the_form
    click_button("Save and continue")
  end

  def and_i_should_see_my_decision
    page.find_by_id("application-#{@first_application_id}", text: "Approved")
  end

  def then_i_should_be_redirected_to_application_list_page
    expect(current_path).to eq("/officer/landing-applications")
  end

  def when_i_complete_the_form
    page.choose("Approve")
    click_button("Save and continue")
  end

  def when_i_select_make_a_decision
    click_link("Make a decision", match: :first)
  end

  def then_i_should_see_the_decision_page
    expect(page).to have_content("Do you approve this application for landing?")
  end
end

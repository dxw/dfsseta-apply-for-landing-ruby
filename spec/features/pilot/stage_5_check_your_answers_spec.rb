# frozen_string_literal: true

# Feature: Stage 5: Check your answers
#   So that I can review my answers and navigate to each stage to make an edit
#   As a pilot applying to make a landing
#   I want to review my answers and edit them if necessary

RSpec.feature "Stage 4: Check your answers" do
  scenario "Confirm and apply" do
    # Given I have completed all the required stages
    # And I am on the final 'Check your answers' stage
    # Then I see all the questions together with my answers
    # When I confirm that I've reviewed my answers and wish to apply
    # Then I receive an application confirmation
  end

  scenario "Change answers" do
    # Given I have completed all the required stages
    # And I am on the final 'Check your answers' stage
    # When I choose to change an answer
    # Then I see my saved answers
    # And can advance through the stages back to 'Confirm your answers'
  end

end

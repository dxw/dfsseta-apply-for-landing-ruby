# frozen_string_literal: true

# Feature: Stage 5: Check your answers
#   So that I can review my answers and navigate to each stage to make an edit
#   As a pilot applying to make a landing
#   I want to review my answers and edit them if necessary

RSpec.feature "Stage 4: Check your answers" do
  scenario "Confirm and apply" do
    given_i_have_completed_all_the_required_stages
    and_i_am_on_the_final_check_your_answers_stage
    then_i_see_all_the_questions_together_with_my_answers

    when_i_confirm_that_i_ve_reviewed_my_answers_and_wish_to_apply
    then_i_receive_an_application_confirmation
  end

  scenario "Change answers" do
    # Given I have completed all the required stages
    # And I am on the final 'Check your answers' stage
    # When I choose to change an answer
    # Then I see my saved answers
    # And can advance through the stages back to 'Confirm your answers'
  end

  def given_i_have_completed_all_the_required_stages
    complete_destination_stage
    complete_dates_stage
    complete_registration_identifier_stage
    complete_personal_details_stage
  end

  def and_i_am_on_the_final_check_your_answers_stage
    visit(stages_check_your_answers_path)
    expect(page).to have_content("Check your answers")
  end

  def then_i_see_all_the_questions_together_with_my_answers
    stages.each do |stage|
      within ".stage[data-stage='#{stage.name}']" do
        expect(page).to have_css("h2", text: stage.title)

        within ".govuk-summary-card__action" do
          expect(page).to have_css("a[href='#{stage.link_path}']", text: "Change #{stage.link_text}")
        end

        stage.questions.each do |question|
          within(".question[data-question='#{question.ref}']") do
            within("dt") { expect(page).to have_content(question.title) }
            within("dd") { expect(page).to have_content(question.answer) }
          end
        end
      end
    end
  end

  def when_i_confirm_that_i_ve_reviewed_my_answers_and_wish_to_apply
    flunk("Not implemented")
    click_button("Confirm and apply")
  end

  # helpers

  Stage = Struct.new(:name, :title, :link_path, :link_text, :questions, keyword_init: true)
  Question = Struct.new(:ref, :title, :answer, keyword_init: true)

  def stages
    @stages = [
      Stage.new(
        name: "destination",
        title: "Destination",
        link_path: stages_destination_path,
        link_text: "destination",
        questions: [
          Question.new(
            ref: :destination,
            title: "Destination",
            answer: "Saturn (core)"
          )
        ]
      ),
      Stage.new(
        name: "dates",
        title: "Dates",
        link_path: stages_dates_path,
        link_text: "dates",
        questions: [
          Question.new(
            ref: :landing_date,
            title: "Requested landing date",
            answer: "10 August #{Date.today.year + 1}"
          ),
          Question.new(
            ref: :departure_date,
            title: "Requested departure date",
            answer: "18 August #{Date.today.year + 1}"
          )
        ]
      )
    ]
  end

  def complete_destination_stage
    visit(stages_destination_path)
    choose("Saturn (core)")
    click_button("Save and continue")
  end

  def complete_dates_stage
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

    click_button("Save and continue")
  end

  def complete_registration_identifier_stage
    fill_in("Registration ID", with: "ABC123X")
    click_button("Save and continue")
  end

  def complete_personal_details_stage
    fill_in("Full name", with: "Roger Smith")
    fill_in("Email address", with: "roger@example.com")
    fill_in("Licence ID", with: "12345678")

    click_button("Save and continue")
  end

end

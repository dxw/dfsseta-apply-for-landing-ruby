RSpec.describe AssessmentDecisionForm do
  describe "it validates presence of application_decision" do
    context "when application_decision is missing" do
      let(:form) { AssessmentDecisionForm.new(application_decision: nil) }

      it "should flag an error" do
        form.valid?

        aggregate_failures do
          expect(form.errors).to include(:application_decision)
          expect(form.errors.full_messages.join).to match("Select either 'Approve' or 'Deny'")
        end
      end
    end

    context "when application_decision is present" do
      let(:form) { AssessmentDecisionForm.new(application_decision: "approved") }

      it "should NOT flag an error" do
        form.valid?

        expect(form.errors).to_not include(:application_decision)
      end
    end

    context "when application_decision is present with an incorrect value" do
      let(:form) { AssessmentDecisionForm.new(application_decision: "something else") }

      it "should flag an error" do
        form.valid?

        expect(form.errors).to include(:application_decision)
      end
    end
  end
end

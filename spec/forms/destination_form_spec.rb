RSpec.describe DestinationForm do
  describe "it validates presence of destination" do
    context "when destination is blank" do
      let(:form) { DestinationForm.new(destination_id: "") }

      it "should flag an error" do
        form.valid?

        aggregate_failures do
          expect(form.errors).to include(:destination_id)
          expect(form.errors.full_messages.join).to match("You must choose a destination")
        end
      end
    end

    context "when destination is present" do
      let(:form) { DestinationForm.new(destination_id: "abc123") }

      it "should not flag an error" do
        form.valid?

        expect(form.errors).to_not include(:destination_id)
      end
    end
  end
end

RSpec.describe SpacecraftRegistrationIdentifierForm do
  describe "it validates presence of SpacecraftRegistrationIdentifier" do
    context "when SpacecraftRegistrationIdentifier is blank" do
      let(:form) { SpacecraftRegistrationIdentifierForm.new(registration_id: "") }

      it "should flag an error" do
        form.valid?

        aggregate_failures do
          expect(form.errors).to include(:registration_id)
          expect(form.errors.full_messages.join).to match("Enter a Spacecraft Registration Identifier")
        end
      end
    end

    context "when SpacecraftRegistrationIdentifier is present" do
      let(:form) { SpacecraftRegistrationIdentifierForm.new(registration_id: "ABC123A") }

      it "should not flag an error" do
        form.valid?

        expect(form.errors).to_not include(:registration_id)
      end
    end
  end

  describe "it validates the format of the Registration ID" do
    context "when it conforms to [3 letters - 3 digits - 1 letter]" do
      let(:form) { SpacecraftRegistrationIdentifierForm.new(registration_id: "XXX999X") }

      it "should not flag an error" do
        form.valid?

        expect(form.errors).to_not include(:registration_id)
      end
    end

    context "when it does NOT conform to (3 letters - 3 digits - 1 letter)" do
      let(:form) { SpacecraftRegistrationIdentifierForm.new(registration_id: "XX1234XX") }

      it "should flag an error" do
        form.valid?

        aggregate_failures do
          expect(form.errors).to include(:registration_id)
          expect(form.errors.full_messages.join).to match("Enter a Spacecraft Registration Identifier in the form ABC123A")
        end
      end
    end
  end
end

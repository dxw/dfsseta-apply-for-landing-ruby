RSpec.describe PersonalDetailsForm do
  describe ":fullname field" do
    context "when :fullname is blank" do
      let(:form) { PersonalDetailsForm.new(fullname: "") }

      it "should flag an error" do
        form.valid?

        aggregate_failures do
          expect(form.errors).to include(:fullname)
          expect(form.errors.full_messages.join).to match("Enter your full name")
        end
      end
    end

    context "when :fullname is present" do
      let(:form) { PersonalDetailsForm.new(fullname: "Roger Smith") }

      it "should not flag an error" do
        form.valid?

        expect(form.errors).to_not include(:fullname)
      end
    end
  end

  describe ":email field" do
    describe "it validates presence of :email" do
      context "when :email is blank" do
        let(:form) { PersonalDetailsForm.new(email: "") }

        it "should flag an error" do
          form.valid?

          aggregate_failures do
            expect(form.errors).to include(:email)
            expect(form.errors.full_messages.join).to match("Enter your email address")
          end
        end
      end

      context "when :email is present, in valid format" do
        let(:form) { PersonalDetailsForm.new(email: "roger@example.com") }

        it "should not flag an error" do
          form.valid?

          expect(form.errors).to_not include(:email)
        end
      end
    end

    describe "validates format" do
      context "when it does not have an @ symbol" do
        let(:form) { PersonalDetailsForm.new(email: "roger.example.com") }

        it "should flag an error" do
          form.valid?

          aggregate_failures do
            expect(form.errors).to include(:email)
            expect(form.errors.full_messages.join).to match(
              "Enter an email address in the correct format, like name@example.com"
            )
          end
        end
      end

      context "when it does not end with an top-level domain" do
        let(:form) { PersonalDetailsForm.new(email: "roger@example") }

        it "should flag an error" do
          form.valid?

          aggregate_failures do
            expect(form.errors).to include(:email)
            expect(form.errors.full_messages.join).to match("Enter an email address in the correct format, like name@example.com")
          end
        end
      end
    end
  end

  describe ":licence_id field" do
    describe "it validates presence of :licence_id" do
      context "when :licence_id is blank" do
        let(:form) { PersonalDetailsForm.new(licence_id: "") }

        it "should flag an error" do
          form.valid?

          aggregate_failures do
            expect(form.errors).to include(:licence_id)
            expect(form.errors.full_messages.join).to match("Enter your Licence ID")
          end
        end
      end

      context "when :licence_id is present, in valid format" do
        let(:form) { PersonalDetailsForm.new(licence_id: "12345678") }

        it "should not flag an error" do
          form.valid?

          expect(form.errors).to_not include(:licence_id)
        end
      end
    end

    describe "validates format" do
      context "when it is less than eight characters" do
        let(:form) { PersonalDetailsForm.new(licence_id: "1234567") }

        it "should flag an error" do
          form.valid?

          aggregate_failures do
            expect(form.errors).to include(:licence_id)
            expect(form.errors.full_messages.join).to match("Your Licence ID must contain at least 8 characters")
          end
        end
      end
    end
  end
end

RSpec.describe DatesForm do
  describe "it validates presence of landing_date" do
    context "when landing_date is missing" do
      let(:form) { DatesForm.new(landing_date: nil, departure_date: Date.today) }

      it "should flag an error" do
        form.valid?

        aggregate_failures do
          expect(form.errors).to include(:landing_date)
          expect(form.errors.full_messages.join).to match("Enter a landing date")
        end
      end
    end

    context "when landing_date is present" do
      let(:form) { DatesForm.new(landing_date: Date.today + 1.week, departure_date: Date.today + 2.weeks) }

      it "should NOT flag an error" do
        form.valid?

        expect(form.errors).to_not include(:landing_date)
      end
    end
  end

  describe "it validates presence of departure_date" do
    context "when departure_date is missing" do
      let(:form) { DatesForm.new(landing_date: Date.today, departure_date: nil) }

      it "should flag an error" do
        form.valid?

        aggregate_failures do
          expect(form.errors).to include(:departure_date)
          expect(form.errors.full_messages.join).to match("Enter a departure date")
        end
      end
    end

    context "when departure_date is present" do
      let(:form) { DatesForm.new(landing_date: Date.today + 1.week, departure_date: Date.today + 2.weeks) }

      it "should NOT flag an error" do
        form.valid?

        expect(form.errors).to_not include(:departure_date)
      end
    end
  end

  describe "ensure that departure date is not before landing date" do
    let(:tomorrow) { Date.today + 1.day }
    let(:day_after_tomorrow) { Date.today + 2.days }

    context "when departure date IS before landing date" do
      let(:form) { DatesForm.new(landing_date: day_after_tomorrow, departure_date: tomorrow) }

      it "should flag an error" do
        form.valid?

        aggregate_failures do
          expect(form.errors).to include(:base)
          expect(form.errors.full_messages.join).to match("Landing date must be earlier than departure date")
        end
      end
    end

    context "when departure date is after landing date" do
      let(:form) { DatesForm.new(landing_date: tomorrow, departure_date: day_after_tomorrow) }

      it "should NOT flag an error" do
        form.valid?

        expect(form.errors).to_not include(:base)
      end
    end

    context "when departure date is the same as landing date" do
      let(:form) { DatesForm.new(landing_date: tomorrow, departure_date: tomorrow) }

      it "should NOT flag an error" do
        form.valid?

        expect(form.errors).to_not include(:base)
      end
    end
  end

  describe "ensure that both landing and departure dates are in the future" do
    let(:tomorrow) { Date.today + 1.day }
    let(:yesterday) { Date.today - 1.day }

    context "when landing date is in the past" do
      let(:form) { DatesForm.new(landing_date: yesterday, departure_date: tomorrow) }

      it "should flag an error" do
        form.valid?

        aggregate_failures do
          expect(form.errors).to include(:landing_date)
          expect(form.errors.full_messages.join).to match("Landing date must be in the future")
        end
      end
    end

    context "when departure date is in the past" do
      let(:form) { DatesForm.new(landing_date: tomorrow, departure_date: yesterday) }

      it "should flag an error" do
        form.valid?

        aggregate_failures do
          expect(form.errors).to include(:departure_date)
          expect(form.errors.full_messages.join).to match("Departure date must be in the future")
        end
      end
    end
  end

  describe "ensure departure date is no more than 14 days after landing date" do
    let(:landing_date) { Date.today + 1.day }

    context "when departure date is less than 14 days after landing date" do
      let(:departure_date) { landing_date + 5.day }

      let(:form) { DatesForm.new(landing_date: landing_date, departure_date: departure_date) }

      it "should NOT flag an error" do
        form.valid?

        expect(form.errors).to_not include(:departure_date)
      end
    end

    context "when departure date is 14 days after landing date" do
      let(:departure_date) { landing_date + 14.day }

      let(:form) { DatesForm.new(landing_date: landing_date, departure_date: departure_date) }

      it "should NOT flag an error" do
        form.valid?

        expect(form.errors).to_not include(:departure_date)
      end
    end

    context "when departure date is more than 14 days after landing date" do
      let(:departure_date) { landing_date + 15.day }

      let(:form) { DatesForm.new(landing_date: landing_date, departure_date: departure_date) }

      it "should flag an error" do
        form.valid?

        expect(form.errors).to include(:departure_date)
        expect(form.errors.full_messages.join).to match("Departure date must be within 14 days of landing date")
      end
    end
  end

  describe "ensure landing and departure dates do not fall on bank holidays" do
    context "when they fall on bank holidays" do
      let(:landing_date) { Date.new(Date.today.year + 1, 12, 25) }
      let(:departure_date) { Date.new(Date.today.year + 1, 12, 26) }

      let(:form) { DatesForm.new(landing_date: landing_date, departure_date: departure_date) }

      it "should flag an error" do
        form.valid?

        expect(form.errors).to include(:departure_date, :landing_date)
        expect(form.errors.full_messages.join).to match("Landing date must not fall on a bank holiday")
        expect(form.errors.full_messages.join).to match("Departure date must not fall on a bank holiday")
      end
    end
  end
end

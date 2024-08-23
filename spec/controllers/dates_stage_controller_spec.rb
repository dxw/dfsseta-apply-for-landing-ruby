require "rails_helper"

RSpec.describe Stages::DatesStageController do
  describe "GET to :show" do
    mock_bank_holidays = ["2026-02-01", "2026-02-02", "2026-02-03"]

    it "calls DateForm.new with a list of bank holidays" do
      expect(BankHolidaysService).to receive(:load).and_return(mock_bank_holidays)
      allow(DatesForm).to receive(:new)

      get :show

      expect(DatesForm).to have_received(:new).with(departure_date: nil, landing_date: nil, bank_holidays: mock_bank_holidays)
    end
  end
end

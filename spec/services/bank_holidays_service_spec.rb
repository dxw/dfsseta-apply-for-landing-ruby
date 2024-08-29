RSpec.describe BankHolidaysService do
  describe "load" do
    before do
      allow(File).to receive(:read).and_return(json)
      allow(JSON).to receive(:parse).and_return(JSON.parse(json))
    end

    let(:json) do
      <<~JSON
        {
          "england-and-wales": {
            "division": "england-and-wales",
              "events": []
          }
        }
      JSON
    end

    it "reads the JSON file containing the UK holidays" do
      BankHolidaysService.load

      expect(File).to have_received(:read)
        .with("#{Rails.root}/config/bank_holidays_uk.json")
    end

    it "parses the JSON contained in this file" do
      BankHolidaysService.load

      expect(JSON).to have_received(:parse).with(json)
    end
  end
end

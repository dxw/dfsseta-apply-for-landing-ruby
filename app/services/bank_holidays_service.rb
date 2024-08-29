class BankHolidaysService
  def self.load
    JSON.parse(File.read("#{Rails.root}/config/bank_holidays_uk.json"))
      .dig("england-and-wales", "events")
      .map { |event| event.fetch("date") }
  end
end

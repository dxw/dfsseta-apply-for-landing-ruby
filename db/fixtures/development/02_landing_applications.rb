class ApplicationSeedHelper
  class << self
    def seed
      seeds.each do |seed|
        LandingApplication.seed_once(:pilot_email) do |s|
          first_name = seed.fetch(:first_name)
          last_name = seed.fetch(:last_name)

          s.pilot_name = "#{first_name} #{last_name}"
          s.pilot_email = "#{first_name}.#{last_name}@example.test"

          s.pilot_licence_id = Faker::Alphanumeric.alphanumeric(number: 8).upcase
          s.spacecraft_registration_id = spacecraft_registration_id
          s.destination = LandableBody.all.sample

          landing_date = landing_date(temporality: seed.fetch(:temporality))
          s.landing_date = landing_date
          s.departure_date = up_to_twelve_days_ahead(landing_date)
          s.application_submitted_at = upto_forty_five_days_before(landing_date)

          s.application_reference = ApplicationReferenceGenerator.generate
        end
      end
    end

    def up_to_twelve_days_ahead(landing_date)
      landing_date + rand(1..12).days
    end

    def upto_forty_five_days_before(landing_date)
      landing_date - rand(1..45).days
    end

    def spacecraft_registration_id
      [
        Faker::Alphanumeric.alphanumeric(number: 3, min_numeric: 3),
        Faker::Alphanumeric.alpha(number: 3),
        Faker::Alphanumeric.alphanumeric(number: 3, min_numeric: 3)
      ].join.upcase
    end

    def seeds
      [
        {first_name: "Lula", last_name: "Willms", temporality: :past},
        {first_name: "Corrin", last_name: "Toy", temporality: :past},
        {first_name: "Wally", last_name: "Larkin", temporality: :past},
        {first_name: "Boris", last_name: "Schumm", temporality: :past},
        {first_name: "Julian", last_name: "Doyle", temporality: :past},
        {first_name: "Delmer", last_name: "Lynch", temporality: :past},
        {first_name: "Marielle", last_name: "Kirlin", temporality: :past},
        {first_name: "Muoi", last_name: "Spinka", temporality: :past},
        {first_name: "Shonta", last_name: "O'Connell", temporality: :past},
        {first_name: "Roxie", last_name: "Balistreri", temporality: :past},

        {first_name: "Alise", last_name: "Gutmann", temporality: :current},
        {first_name: "Colette", last_name: "Quitzon", temporality: :current},
        {first_name: "Ferne", last_name: "Koch", temporality: :current},
        {first_name: "Danilo", last_name: "Kunze", temporality: :current},
        {first_name: "Derrick", last_name: "Rippin", temporality: :current},
        {first_name: "Virgen", last_name: "Fadel", temporality: :current},
        {first_name: "Clifton", last_name: "Klocko", temporality: :current},
        {first_name: "Tiana", last_name: "Mills", temporality: :current},
        {first_name: "Elvina", last_name: "Batz", temporality: :current},
        {first_name: "Jonah", last_name: "Blick", temporality: :current},

        {first_name: "Nga", last_name: "Mraz", temporality: :future},
        {first_name: "Augustine", last_name: "Hoppe", temporality: :future},
        {first_name: "Ian", last_name: "Abbott", temporality: :future},
        {first_name: "Jaye", last_name: "Dickinson", temporality: :future},
        {first_name: "Stuart", last_name: "Davis", temporality: :future},
        {first_name: "Lorenzo", last_name: "Steuber", temporality: :future},
        {first_name: "Felisha", last_name: "Gottlieb", temporality: :future},
        {first_name: "Rodolfo", last_name: "McClure", temporality: :future},
        {first_name: "Mitzie", last_name: "Rosenbaum", temporality: :future},
        {first_name: "Luanna", last_name: "Roberts", temporality: :future}
      ]
    end

    def landing_date(temporality:)
      case temporality
      when :current
        # today or up to 2 days in the future
        Date.today + rand(0..2).days
      when :future
        # between 2 and 11 weeks in the future
        Date.today + 2.weeks + rand(0..9).weeks
      when :past
        # between 2 and 11 weeks in the past
        Date.today - 2.weeks + rand(0..9).weeks
      end
    end
  end
end

ApplicationSeedHelper.seed

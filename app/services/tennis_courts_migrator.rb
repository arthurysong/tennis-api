# frozen_string_literal: true

class TennisCourtsMigrator
  STATES = [%w[Alabama AL],
            %w[Alaska AK],
            %w[Arizona AZ],
            %w[Arkansas AR],
            %w[California CA],
            %w[Colorado CO],
            %w[Connecticut CT],
            %w[Delaware DE],
            %w[Florida FL],
            %w[Georgia GA],
            %w[Hawaii HI],
            %w[Idaho ID],
            %w[Illinois IL],
            %w[Indiana IN],
            %w[Iowa IA],
            %w[Kansas KS],
            %w[Kentucky KY],
            %w[Louisiana LA],
            %w[Maine ME],
            %w[Maryland MD],
            %w[Massachusetts MA],
            %w[Michigan MI],
            %w[Minnesota MN],
            %w[Mississippi MS],
            %w[Missouri MO],
            %w[Montana MT],
            %w[Nebraska NE],
            %w[Nevada NV],
            ['New Hampshire', 'NH'],
            ['New Jersey', 'NJ'],
            ['New Mexico', 'NM'],
            ['New York', 'NY'],
            ['North Carolina', 'NC'],
            ['North Dakota', 'ND'],
            %w[Ohio OH],
            %w[Oklahoma OK],
            %w[Oregon OR],
            %w[Pennsylvania PA],
            ['Rhode Island', 'RI'],
            ['South Carolina', 'SC'],
            ['South Dakota', 'SD'],
            %w[Tennessee TN],
            %w[Texas TX],
            %w[Utah UT],
            %w[Vermont VT],
            %w[Virginia VA],
            %w[Washington WA],
            ['West Virginia', 'WV'],
            %w[Wisconsi WI],
            %w[Wyoming WY]].freeze

  # ! this is only for california.
  def self.query_and_insert_tennis_courts
    ScrapeService.ca_cities.each do |city|
      lat, long = GeocoderService.geocode_city(city, 'CA')

      unless lat && long
        Rails.logger.error "Lat Long not available for city, #{city}"
        next
      end

      results = GooglePlacesService.query_courts(lat, long)
      TennisCourt.create_from_results(results)
    end
  end

  def self.migrate_tennis_courts_in_usa
    STATES.each do |state|
      state_input = state[0].downcase.gsub(' ', '-')
      state_two_letter = state[1]

      ScrapeService.get_cities(state_input).each do |city|
        lat, long = GeocoderService.geocode_city(city, state_two_letter)

        unless lat && long
          Rails.logger.error "Lat Long not available for city, #{city}"
          next
        end

        results = GooglePlacesService.query_courts(lat, long)
        TennisCourt.create_from_results(results)
      end
    end
  end
end

FactoryBot.define do
  factory :sample do
    sample_name { Faker::TvShows::Seinfeld.character }
    product_matrix { Faker::TvShows::Seinfeld.character }
    unit_measurement { (1..9).to_a.sample }
    unit_of_measurement { Sample.unit_of_measurements.keys.sample }
  end
end

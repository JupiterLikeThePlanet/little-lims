FactoryBot.define do
  factory :sample_report do
    sample { create(:sample) }
  end
end

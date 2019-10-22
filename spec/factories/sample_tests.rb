FactoryBot.define do
  factory :sample_test do
    test { Test.cannabinoids }
    sample { create(:sample) }
  end
end

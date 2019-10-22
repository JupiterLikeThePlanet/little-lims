FactoryBot.define do
  factory :sample_test_report do
    sample_report { create(:sample_report) }
    input_units { SampleReportTest::PERCENTAGE }
    primary_display_units { SampleReportTest::PERCENTAGE }
    secondary_display_units { SampleReportTest::MILLIGRAMS_PER_GRAM }
    sample_test { create(:sample_test, sample: sample_report.sample) }
  end
end

class SampleTest < ApplicationRecord
  belongs_to :sample
  belongs_to :test
  has_many :sample_test_reports, dependent: :destroy
end

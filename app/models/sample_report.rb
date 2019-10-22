class SampleReport < ApplicationRecord
  belongs_to :sample
  has_many :sample_test_reports, dependent: :destroy
end

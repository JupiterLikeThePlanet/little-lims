class SampleTestReport < ApplicationRecord
  belongs_to :sample_report
  belongs_to :sample_test

  delegate :sample, :test, to: :sample_test

  validates :input_units, inclusion: UnitConverter::UNITS
  validates :primary_display_units, inclusion: UnitConverter::UNITS
  validates :secondary_display_units, inclusion: UnitConverter::UNITS

  def display_units_valid?(display_units)
    display_units.in?(UnitConverter::UNITS)
  end
end

class Sample < ApplicationRecord
  has_many :sample_tests, dependent: :destroy
  has_many :sample_reports, dependent: :destroy
  has_many :sample_test_reports, through: :sample_reports

  enum unit_of_measurement: { grams: 0, milliliters: 1, ounces: 2, fluid_ounces: 3 }, _prefix: true

  validates :unit_measurement, numericality: { greater_than: 0 }, allow_nil: true
  validates :unit_weight_in_grams, numericality: { greater_than: 0 }, allow_nil: true
  validates :grams_per_ml, numericality: { greater_than: 0 }, allow_nil: true

  before_save :set_calculated_fields

  def certificate_of_analysis
    SampleReport.find_or_create_by!(sample: self)
  end

  private

  def set_calculated_fields
    return unless unit_of_measurement

    self.unit_weight_in_grams = determine_unit_weight_in_grams
  end

  def determine_unit_weight_in_grams
    case unit_of_measurement
    when 'grams' then unit_measurement
    when 'ounces' then unit_measurement&.*(UnitConverter::GRAMS_PER_OZ)
    end
  end
end

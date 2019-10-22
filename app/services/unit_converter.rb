class UnitConverter
  attr_reader :sample_test_report

  GRAMS_PER_OZ = 28.349523125 # https://en.wikipedia.org/wiki/Ounce#International_avoirdupois_ounce

  UNITS = [
    PERCENTAGE = '%'.freeze,
    MILLIGRAMS_PER_GRAM = 'mg/g'.freeze,
    PARTS_PER_MILLION = 'PPM'.freeze
  ].freeze

  MILLIGRAM_CONVERSION_FACTOR = {
    PERCENTAGE => 1e1,
    MILLIGRAMS_PER_GRAM => 1,
    PARTS_PER_MILLION => 1e-3
  }.freeze

  DISPLAY_CONVERSION_FACTOR = {
    PERCENTAGE => 1e-1,
    MILLIGRAMS_PER_GRAM => 1,
    PARTS_PER_MILLION => 1e3
  }.freeze

  def initialize(sample_test_report)
    @sample_test_report = sample_test_report
  end

  def convert(unconverted_value, display_units: :primary_display_units)
    display_units = display_units(display_units: display_units)
    return unless unconverted_value && display_units

    unconverted_value * conversion_factor(display_units)
  end

  private

    def conversion_factor(alternate_units)
      input_unit_conversion_factor * display_conversion_factor(alternate_units)
    end

    def display_units(display_units:)
      case display_units
      when :primary_display_units then sample_test_report.primary_display_units
      when :secondary_display_units then sample_test_report.secondary_display_units
      else
        return unless sample_test_report.display_units_valid?(display_units)

        display_units
      end
    end

    def display_conversion_factor(display_units)
      DISPLAY_CONVERSION_FACTOR[display_units]
    end

    def input_unit_conversion_factor
      MILLIGRAM_CONVERSION_FACTOR[sample_test_report.input_units]
    end
end

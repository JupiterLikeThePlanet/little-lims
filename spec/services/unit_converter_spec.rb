require 'rails_helper'

RSpec.describe UnitConverter, type: :service do
  subject { described_class.new(sample_test_report) }

  let(:decimal_places) { 2 }
  let(:sample_test) { create(:sample_test, sample: sample, test: Test.cannabinoids) }
  let(:sample) { create(:sample) }
  let(:sample_report) { sample.certificate_of_analysis }
  let(:sample_test_report) do
    create(
      :sample_test_report,
      sample_test: sample_test,
      sample_report: sample_report,
      decimal_places: decimal_places,
      input_units: iu,
      primary_display_units: pdu,
      secondary_display_units: sdu
    )
  end

  describe '#convert' do
    let(:iu) { UnitConverter::PERCENTAGE }
    let(:pdu) { UnitConverter::PERCENTAGE }
    let(:sdu) { UnitConverter::PARTS_PER_MILLION }
    let(:original_value) { 5 }
    let(:converted_value) { subject.convert(original_value) }

    before do
      sample.update!(unit_weight_in_grams: 2)
    end

    context 'no value' do
      it { expect(subject.convert(nil, display_units: UnitConverter::MILLIGRAMS_PER_GRAM)).to eq(nil) }
    end

    context 'provide display_units' do
      it { expect(subject.convert(original_value, display_units: UnitConverter::MILLIGRAMS_PER_GRAM)).to eq(50) }
    end

    context 'display_units is :secondary_display_units' do
      let(:sdu) { UnitConverter::PARTS_PER_MILLION }

      it { expect(subject.convert(original_value, display_units: :secondary_display_units)).to eq(50_000) }
    end

    # Defaults to :primary_display_units
    context 'input_unit is PERCENTAGE' do
      let(:iu) { UnitConverter::PERCENTAGE }

      context 'primary_unit is PERCENTAGE' do
        let(:pdu) { UnitConverter::PERCENTAGE }

        it { expect(converted_value).to eq(original_value) }
      end

      context 'primary_unit is MILLIGRAMS_PER_GRAM' do
        let(:pdu) { UnitConverter::MILLIGRAMS_PER_GRAM }

        it { expect(converted_value).to eq(50) }
      end

      context 'primary_unit is PARTS_PER_MILLION' do
        let(:pdu) { UnitConverter::PARTS_PER_MILLION }

        it { expect(converted_value).to eq(50_000) }
      end

      # context 'primary_unit is MILLIGRAMS_PER_MILLILITER' do
      #   before { sample.update!(grams_per_ml: 5) }
      #
      #   let(:pdu) { UnitConverter::MILLIGRAMS_PER_MILLILITER }
      #
      #   it { expect(converted_value).to eq(250) }
      # end
    end

    context 'input_unit is MILLIGRAMS_PER_GRAM' do
      let(:iu) { UnitConverter::MILLIGRAMS_PER_GRAM }

      context 'primary_unit is PERCENTAGE' do
        let(:pdu) { UnitConverter::PERCENTAGE }

        it { expect(converted_value).to eq(0.5) }
      end

      context 'primary_unit is MILLIGRAMS_PER_GRAM' do
        let(:pdu) { UnitConverter::MILLIGRAMS_PER_GRAM }

        it { expect(converted_value).to eq(original_value) }
      end

      context 'primary_unit is PARTS_PER_MILLION' do
        let(:pdu) { UnitConverter::PARTS_PER_MILLION }

        it { expect(converted_value).to eq(5_000) }
      end

      # context 'primary_unit is MILLIGRAMS_PER_MILLILITER' do
      #   before { sample.update!(grams_per_ml: 5) }
      #
      #   let(:pdu) { UnitConverter::MILLIGRAMS_PER_MILLILITER }
      #
      #   it { expect(converted_value).to eq(25) }
      # end
    end

    context 'input_unit is PARTS_PER_MILLION' do
      let(:iu) { UnitConverter::PARTS_PER_MILLION }

      context 'primary_unit is PERCENTAGE' do
        let(:pdu) { UnitConverter::PERCENTAGE }

        it { expect(converted_value).to be_within(1e-7).of(0.0005) }
      end

      context 'primary_unit is MILLIGRAMS_PER_GRAM' do
        let(:pdu) { UnitConverter::MILLIGRAMS_PER_GRAM }

        it { expect(converted_value).to be_within(1e-7).of(0.005) }
      end

      context 'primary_unit is PARTS_PER_MILLION' do
        let(:pdu) { UnitConverter::PARTS_PER_MILLION }

        it { expect(converted_value).to eq(original_value) }
      end

      # context 'primary_unit is MILLIGRAMS_PER_MILLILITER' do
      #   before { sample.update!(grams_per_ml: 5) }
      #
      #   let(:pdu) { UnitConverter::MILLIGRAMS_PER_MILLILITER }
      #
      #   it { expect(converted_value).to eq(0.025) }
      # end
    end
  end
end

require 'rails_helper'

describe Sample, type: :model do

  describe '#set_calculated_fields' do
    let(:sample) { create(:sample, unit_measurement: unit_measurement, unit_of_measurement: unit_of_measurement) }
    let(:unit_measurement) { 5 }
    let(:unit_of_measurement) { 'grams' }

    context 'unit_measurement changed' do
      before { sample.update!(unit_measurement: 10) }

      context 'and is in grams' do
        let(:unit_of_measurement) { 'grams' }

        it 'sets unit_weight_in_grams' do
          expect(sample.unit_weight_in_grams).to eq(10)
        end
      end

      context 'and is in ounces' do
        let(:unit_of_measurement) { 'ounces' }

        it 'sets unit_weight_in_grams' do
          expect(sample.unit_weight_in_grams).to be_within(0.01).of(283.495)
        end
      end

      context 'and is in mL' do
        let(:unit_of_measurement) { 'milliliters' }

        it 'sets unit_weight_in_grams when density is available' do
          expect(sample.unit_weight_in_grams).to eq(nil)
          # sample.update(grams_per_ml: 3)
          # expect(sample.unit_weight_in_grams).to eq(30)
        end
      end

      context 'and is in fluid_ounces' do
        let(:unit_of_measurement) { 'fluid_ounces' }

        it 'sets unit_weight_in_grams when density is available' do
          expect(sample.unit_weight_in_grams).to eq(nil)
          # sample.update(grams_per_ml: 3)
          # expect(sample.unit_weight_in_grams).to be_within(0.001).of(852.392)
        end
      end
    end

    context 'unit_of_measurement changed' do
      before { sample.update!(unit_of_measurement: new_unit_of_measurement) }

      context 'and becomes grams' do
        let(:unit_of_measurement) { 'ounces' }
        let(:new_unit_of_measurement) { 'grams' }

        it 'sets unit_weight_in_grams' do
          expect(sample.unit_weight_in_grams).to eq(unit_measurement)
        end
      end

      context 'and becomes ounces' do
        let(:new_unit_of_measurement) { 'ounces' }

        it 'sets unit_weight_in_grams' do
          expect(sample.unit_weight_in_grams).to be_within(0.001).of(141.748)
        end
      end

      context 'and becomes milliliters' do
        let(:new_unit_of_measurement) { 'milliliters' }

        it 'sets unit_weight_in_grams when density is available' do
          expect(sample.unit_weight_in_grams).to eq(nil)
          # sample.update!(grams_per_ml: 3)
          # expect(sample.unit_weight_in_grams).to eq(15)
        end
      end

      context 'and becomes fluid_ounces' do
        let(:new_unit_of_measurement) { 'fluid_ounces' }

        it 'sets unit_weight_in_grams when density is available' do
          expect(sample.unit_weight_in_grams).to eq(nil)
          # sample.update!(grams_per_ml: 3)
          # expect(sample.unit_weight_in_grams).to be_within(0.001).of(426.196)
        end
      end
    end
  end

end

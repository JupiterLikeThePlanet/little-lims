require 'rails_helper'

describe Test, type: :model do
  describe '.cannabinoids' do
    it "returns a test with the name #{Test::CANNABINOIDS}" do
      expect(Test.cannabinoids.name).to eq(Test::CANNABINOIDS)
    end
  end
end

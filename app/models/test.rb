class Test < ApplicationRecord
  CANNABINOIDS = 'Cannabinoids'.freeze

  def self.cannabinoids
    find_or_create_by!(name: CANNABINOIDS)
  end
end

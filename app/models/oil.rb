class Oil < ApplicationRecord
  include Storable

  resourcify

  validates :title, :unit, :quantity, :total, presence: true
  validates :price, numericality: { only_integer: true }

  paginates_per 15

  UNITS = [ :liter, :bottle, :canister ]
  enum unit: UNITS

  def units
    UNITS
  end
end

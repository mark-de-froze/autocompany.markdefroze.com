class Part < ApplicationRecord
  resourcify

  include Storable

  validates :title, :unit, :quantity, presence: true
  validates :price, numericality: { only_integer: true }

  paginates_per 15

  UNITS = [ :piece, :box, :kit ]
  enum unit: UNITS

  def units
    UNITS
  end
end

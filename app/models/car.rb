class Car < ApplicationRecord
  resourcify
  include OrderUpdatedAt

  belongs_to :client
  has_many :orders

  validates :brand, :model, :state_number, presence: true
  validates :year, :mileage, numericality: { only_integer: true, :allow_blank => true }

  validates :vin,
            length: { is: 17, :allow_blank => true },
            format: { :with => /\A[a-zA-Z0-9]+\Z/, :allow_blank => true }

  validates :state_number,
            length: { minimum: 6, maximum: 8, :allow_blank => true },
            format: { :with => /\A[a-zA-Z0-9]+\Z/ }

  validates_length_of :year, is: 4, :allow_blank => true

  validates_numericality_of :engine_capacity, :allow_blank => true

  paginates_per 6

  TYPES = [ :reciprocating, :carburetor, :fuel_injection, :hybrid ]
  enum engine_type: TYPES

  def engine_type_text
    self.engine_type.to_s.humanize
  end

  def engine_types
    TYPES
  end

  def to_label
    "#{brand} #{model} #{state_number} #{title}"
  end

  def years
    1990..Date.today.year
  end
end

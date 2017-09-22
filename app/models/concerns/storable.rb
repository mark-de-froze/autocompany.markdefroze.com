module Storable
  extend ActiveSupport::Concern

  included do
    has_many :materials, as: :storable, dependent: :destroy
    has_many :histories, as: :trackable, dependent: :destroy
  end

  def unit_text
    self.unit.to_s.humanize
  end

  def update_quantity quantity, status
    if self.quantity > 0 && status == :deleted
      self.quantity - quantity
    elsif self.quantity > 0 && status == :added
      self.quantity + quantity
    else
      recalculation_quantity
    end
  end

  def recalculation_quantity
    sum = 0
    self.histories.each do |h|
      case h.status.to_sym
        when :added
          sum += h.quantity
        when :deleted
          sum -= h.quantity
      end
    end
    sum if sum > 0
  end

  def to_label
    "#{title} (#{quantity} #{unit_text})"
  end
end
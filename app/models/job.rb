class Job < ApplicationRecord
  resourcify
  include OrderUpdatedAt

  belongs_to :service

  validates :title, :price, presence: true
  validates :price, numericality: { only_integer: true }

  def to_label
    "#{title}"
  end
end

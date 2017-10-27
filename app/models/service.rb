class Service < ApplicationRecord
  resourcify
  include OrderUpdatedAt

  has_and_belongs_to_many :workers
  has_many :jobs

  validates :title, presence: true

  def to_label
    "#{title}"
  end
end

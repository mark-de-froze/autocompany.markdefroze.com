class Worker < ApplicationRecord
  resourcify
  include OrderUpdatedAt

  belongs_to :user
  has_and_belongs_to_many :services
  has_many :tasks
  has_many :orders

  validates :title, presence: true
  validates :user_id, uniqueness: true

  paginates_per 6

  def to_label
    "#{title}"
  end
end

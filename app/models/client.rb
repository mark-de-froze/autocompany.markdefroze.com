class Client < ApplicationRecord
  resourcify
  include OrderUpdatedAt

  belongs_to :user
  has_many :cars
  has_many :orders
  has_and_belongs_to_many :users

  validates :title, :phone, presence: true

  validates :phone,
            format: { :with => /\A(38|7)[0-9]{10}\Z/, :allow_blank => true }

  paginates_per 8

  def to_label
    "#{title}"
  end
end

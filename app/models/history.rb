class History < ApplicationRecord
  resourcify
  include OrderUpdatedAt

  include ApplicationHelper
  belongs_to :trackable, polymorphic: true

  validates :price, :quantity, :status, presence: true
  validates :price, :quantity, numericality: { only_integer: true }

  STATUSES = [ :added, :deleted]
  enum status: STATUSES

  def status_text
    self.status.to_s.humanize
  end

  def statuses
    STATUSES
  end

  def to_label
    "#{status_text} #{date(created_at)} #{title}"
  end
end

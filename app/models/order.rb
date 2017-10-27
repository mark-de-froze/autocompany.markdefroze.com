class Order < ApplicationRecord
  resourcify
  include OrderUpdatedAt

  before_save :update_finished_at
  before_save :update_mileage_car
  before_save :update_title

  belongs_to :client
  belongs_to :worker
  belongs_to :car
  accepts_nested_attributes_for  :car
  has_many :tasks, dependent: :destroy
  has_many :materials, dependent: :destroy

  scope :month, ->(start_date,end_date) { where('created_at >= ? AND created_at <= ?', start_date, end_date) }

  validates :status, presence: true
  validates :mileage, numericality: { only_integer: true, :allow_blank => true }

  STATUSES = [ :opened, :closed ]
  enum status: STATUSES

  def status_text
    self.status.to_s.humanize
  end

  def statuses
    STATUSES
  end

  def to_label
    "Order ##{id}"
  end

  def calculate_amount_tasks
    amount_tasks = 0
    self.tasks.each do |task| amount_tasks += task.price end
    amount_tasks
  end

  def calculate_amount_materials
    amount_materials = 0
    self.materials.each do |task| amount_materials += task.calculate_total end
    amount_materials
  end

  def calculate_total
    self.calculate_amount_tasks + self.calculate_amount_materials
  end

  def calculate_tax
    (self.calculate_total*20)/100
  end

  def calculate_total_with_tax
    self.calculate_total+self.calculate_tax
  end

  def update_finished_at
    self.finished_at = DateTime.now if self.status.to_sym == :closed
  end

  def update_title
    self.title = self.car.to_label if self.title.nil?
  end

  def update_mileage_car
    if car.present?
      if mileage
        self.car.mileage ||= 0
        self.car.mileage = self.mileage if self.car.mileage < self.mileage
      end
    end
  end
end

class Task < ApplicationRecord
  resourcify
  include OrderUpdatedAt

  belongs_to :order
  belongs_to :service
  belongs_to :job
  belongs_to :worker

  def autoload_price
    if self.price.present?
      self.price
    else
      if self.job
        self.job.price
      else
          nil
      end
    end
  end
end

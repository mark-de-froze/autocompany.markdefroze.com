class Material < ApplicationRecord
  resourcify

  after_create :create_storable_history
  before_destroy { self.create_storable_history(:added)}

  belongs_to :order
  belongs_to :storable, polymorphic: true

  validates :price, :quantity, numericality: { only_integer: true }

  TYPES = [ :Oil, :Part ]

  def types
    TYPES
  end

  def storable_all
    self.storable_type.classify.constantize.all.where.not(quantity: 0)
  end

  def autoload_price
    if self.price.present?
      self.price
    else
      if self.storable
        self.storable.price
      else
        nil
      end
    end
  end

  def create_storable_history( status = :deleted )
    trackable = self.storable
    trackable.quantity = trackable.update_quantity(self.quantity,status)

    if self.quantity > 0
      trackable.histories.build({title: self.order.to_label,
                                 status: status,
                                 price: self.price,
                                 code: trackable.code,
                                 quantity: self.quantity})
    end

    if trackable.quantity.nil?
      self.destroy
    end

    trackable.save
  end

  def calculate_total
    self.quantity * self.price
  end
end

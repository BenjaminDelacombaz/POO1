class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { greater_than_or_equal_to: 1, integer: true }
  validates :product,  presence: true

  scope :bulk, -> (min_quantity = 100) { where('quantity >= ?', min_quantity) }

  before_create :set_price

  def price
    quantity * item_price
  end

  # Le problème provient que la validation n'est pas encore faite (elle est faite dans le super)
  # # En plus c'est moche
  # def save
  #   self.item_price = product.price unless product
  #   super
  # end

  protected def set_price
    self.item_price ||= product.price
  end
end

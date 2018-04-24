class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  scope :bulk, ->(size = 100) { where('quantity >= ?', size) }
  
  validates :quantity, numericality: {greater_than_or_equal: 1, only_integer: true}
  validates :product,  presence: true
  validate :product_in_stock?

  before_save :set_item_price

  def price
    quantity * item_price
  end
  
  protected
  
  def set_item_price
    self.item_price ||= product.price
  end
  
  def product_in_stock?
    errors.add(:product, "#{product}: Not enough stock") if product.stock_count < quantity
  end
end

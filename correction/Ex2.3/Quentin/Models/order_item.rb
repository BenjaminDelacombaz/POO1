class Order_item < ActiveRecord::Base
  belongs_to :order
  has_many :product

  def to_s
    "#{product} : #{quantity}"
  end

  scope :bulk, ->(seuil = 100) { where('quantity >= ?', seuil ) }

  def price
    quantity * item_price
  end

end
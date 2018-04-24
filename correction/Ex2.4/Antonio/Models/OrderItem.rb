class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }

  scope :bulk,
        ->(number = 100.00) {
          where('quantity >= ?', number)
        }
end
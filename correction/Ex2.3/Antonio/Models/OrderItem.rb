class Order_item < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  scope :bulk, ->(number) { where('quantity' => number) }
end
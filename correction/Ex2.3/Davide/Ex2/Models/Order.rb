class Order < ActiveRecord::Base
  belongs_to :clients
  has_many :order_items
  has_many :products, through: :order_items
end
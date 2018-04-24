class Order < ActiveRecord::Base
  belongs_to :client
  has_many :order_items
  has_many :products, through: :order_items

  validates :products, presence: true

end
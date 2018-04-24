class Product < ActiveRecord::Base
  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :category
  belongs_to :supplier

  scope :cheap, -> { where("products.price <= ?", 0.2) }
  
  def to_s
    name
  end
end

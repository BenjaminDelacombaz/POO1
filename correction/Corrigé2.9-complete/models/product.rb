class Product < ActiveRecord::Base
  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :category
  belongs_to :supplier
  has_many :comments, as: :target

  scope :cheap, -> { where("products.price <= ?", 0.2) }
  
  def to_s
    name
  end
  
  def reduce_stock_by(quantity)
    update(stock_count: stock_count - quantity)
  end
end

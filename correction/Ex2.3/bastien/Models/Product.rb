class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :order_items
  has_many :orders, through: :order_items
  
  scope :cheap, -> { where('price <= ?', 20) }

  def to_s
    name
  end
end
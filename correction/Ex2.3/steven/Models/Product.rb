class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :order_items
  has_many :orders, through: :order_items

  def to_s
    "#{name} #{price} #{description}"
  end
  scope :cheap, -> { where('price < ?', 0.20) }
end
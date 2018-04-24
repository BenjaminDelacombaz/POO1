class Client < ActiveRecord::Base
  has_many :orders
  has_many :ordered_products, lambda { distinct }, through: :orders, source: :products

  def to_s
    "#{firstname} #{lastname}"
  end
end

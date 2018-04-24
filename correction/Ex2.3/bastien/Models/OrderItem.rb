class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  
  def self.bulk(threshold=100)
    where('quantity >= ?', threshold)
  end
end
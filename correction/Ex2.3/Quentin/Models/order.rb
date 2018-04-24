class Order < ActiveRecord::Base
  has_many :order_items
  validates_associated :order_items, presence: true
  belongs_to :client

  validates :created_at, :status, :client_id, presence: true

  def to_s
    "#{status} : #{client}, total : #{price}"
  end

  def price
    order_items.sum {|oi| oi.price}
  end
end
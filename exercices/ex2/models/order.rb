class Order < ActiveRecord::Base
  belongs_to :client
  has_many :order_items
  has_many :products, through: :order_items

  around_update :update_stock

  # Ne marche pas car le test est fait avant qu'un order items soie créé
  # validates :products, presence: true

  def total_price
    # Beurk
    # total_price = 0
    # self.order_items.each {|order_item| total_price += order_item.quantity * order_item.item_price}
    # total_price
    
    # Moit moit beurk
    # order_items.collect {|oi| oi.item_price * oi.quantity}.reduce(:+)

    order_items.sum {|oi| oi.price}
  end
  
  def update_stock
    if status === 2
      self.order_items.each {|order_item| puts "#{order_item.quantity} #{order_item.product}"}
    end
    yield
    #do something else...
  end
end

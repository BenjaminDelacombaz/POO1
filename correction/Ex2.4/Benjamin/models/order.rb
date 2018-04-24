class Order < ActiveRecord::Base
    belongs_to :client
    has_many :order_items
    has_many :products, through: :order_items

    validates :products, presence: true

    def total_price
        # Beurk
        # total_price = 0
        # self.order_items.each {|order_item| total_price += order_item.quantity * order_item.item_price}
        # total_price
        
        order_items.collect {|oi| oi.item_price * oi.quantity}.reduce(:+)
    end
end

class Order < ActiveRecord::Base
    belongs_to :client
    has_many :order_items
    has_many :products, through: :order_items

    validates :products, presence: true

    def to_s
        "#{status} : #{client}, total : #{calculateTotal}"
    end

    def calculateTotal
        order_items.collect {|oi| oi.item_price * oi.quantity}.reduce(:+)
    end

end
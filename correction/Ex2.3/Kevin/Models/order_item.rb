class OrderItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :product

    scope :bulk,
        -> (quantity = 100.00) {
            where('quantity >= ?', quantity)
        }

    def to_s
        "#{quantity} : #{product}"
    end

end
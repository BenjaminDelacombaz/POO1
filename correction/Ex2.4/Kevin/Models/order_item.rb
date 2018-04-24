class OrderItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :product

    validates :quantity, numericality: { greater_than: 0 }

    scope :bulk,
        -> (quantity = 100) {
            where('quantity >= ?', quantity)
        }

    def to_s
        "#{quantity} : #{product}"
    end

end
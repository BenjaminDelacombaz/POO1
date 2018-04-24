class OrderItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :product
    scope :bulk, ->(quantity = 100) { where('quantity >= ?', quantity) }

    validates :id, :quantity, presence: true, numericality: { greather_than: 1 }


    def to_s
        "#{quantity} : #{product}"
    end
end

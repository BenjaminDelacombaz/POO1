class OrderItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :product

    scope :bulk, -> (min_quantity: 100) { where('quantity <= ?', min_quantity) }
end

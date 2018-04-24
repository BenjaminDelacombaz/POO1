class Client < ActiveRecord::Base
    has_many :orders
    has_many :ordered_products, -> { distinct }, through: :orders, source: :products

    validates :lastname, :firstname, presence: true, length: { minimum: 2 }

    def to_s
        "#{firstname} #{lastname}"
    end
end

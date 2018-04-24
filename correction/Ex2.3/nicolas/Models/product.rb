class Product < ActiveRecord::Base
    has_many :order_items
    has_and_belongs_to_many :categories

    scope :cheap, -> { where("price <= ?", 0.20) }

    def to_s
        "#{name} #{price}"
    end
end

class Product < ActiveRecord::Base
    has_and_belongs_to_many :category
    has_many :order_items
    has_many :order, through: :order_items
end
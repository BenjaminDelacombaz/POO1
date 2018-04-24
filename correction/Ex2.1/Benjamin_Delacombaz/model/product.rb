class Product < ActiveRecord::Base
    has_and_belongs_to_many :products
    has_many :orderitems
    has_many :orders, through: :orderitems
end

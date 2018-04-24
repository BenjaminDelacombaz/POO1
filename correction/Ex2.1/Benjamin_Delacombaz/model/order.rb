class Order < ActiveRecord::Base
    belongs_to :client
    has_many :orderitems
    has_many :products, through: :orderitems
end

class Product < ActiveRecord::Base
  has_many :orderitems
end
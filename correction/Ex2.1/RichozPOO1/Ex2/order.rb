class Order < ActiveRecord::Base
  belongs_to :orderitems
  belongs_to :clients
end
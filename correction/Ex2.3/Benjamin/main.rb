require 'bundler'
Bundler.require
require_relative 'connection'
require_relative 'model/client'
require_relative 'model/product'
require_relative 'model/category'
require_relative 'model/order'
require_relative 'model/order_item'

client = Client.last

products = OrderItem.bulk.product

# puts client.orders.first.products.cheap.first.name

products.each do |product|
    puts products.id
end

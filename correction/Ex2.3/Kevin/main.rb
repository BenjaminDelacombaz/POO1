require 'bundler'
Bundler.require

require_relative 'connection'

require_relative 'Models/category'
require_relative 'Models/client'
require_relative 'Models/order'
require_relative 'Models/order_item'
require_relative 'Models/product'

#
# Programme principal
#

Client.first.orders.each do |order|
    order.products.cheap.each do |product|
        puts product
    end
 end

 Client.first.orders.each do |order|
    order.order_items.bulk(50).each do |item|
        puts item.product
    end
 end

 Product.all.each do |product|
    puts product
 end

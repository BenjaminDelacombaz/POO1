require 'bundler'
Bundler.require
require_relative 'connection'
require_relative 'models/client'
require_relative 'models/product'
require_relative 'models/category'
require_relative 'models/order'
require_relative 'models/order_item'

# client = Client.last

# Moche
# cheap_products = []
# client.orders.each {|order| order.products.cheap.each {|product| cheap_products.push(product) } }

# Beau
# puts client.ordered_products.cheap

# bulk_products = OrderItem.bulk(50).map {|oi| oi.product}
# puts bulk_products

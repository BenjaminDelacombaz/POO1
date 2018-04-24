# Bundle require
require 'bundler'
Bundler.require

# Import database connexion
require_relative 'connection'

# Import migrations

# Import active records
require_relative 'Models/Client'
require_relative 'Models/Order'
require_relative 'Models/OrderItem'
require_relative 'Models/Product'
require_relative 'Models/Category'

#
# Programme principal
#
puts 'Les produis pas chers :'

Client.find(2).orders.each { |order| order.products.cheap.each { |product| puts product } }
#Product.cheap.each { |e| puts e.name }

puts 'Les grosses commandes :'

Client.find(2).orders.each { |order| order.order_items.bulk(50).each { |oitem| puts oitem.product } }
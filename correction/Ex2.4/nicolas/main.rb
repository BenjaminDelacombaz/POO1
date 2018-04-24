require 'bundler'
Bundler.require
require_relative 'connection'
require_relative 'Models/category'
require_relative 'Models/client'
require_relative 'Models/order_item'
require_relative 'Models/order'
require_relative 'Models/product'

#
# Programme principal
#

#products = Product.all

#products.each do |product|
    
#    puts product.price
#end

# Product.cheap.each { |p| puts p }

# cheap_products = []
# client.orders.each{|order| order.products.cheap.each {|product| cheap_products.push product } }
# puts client.products.cheap

#- Un client doit avoir un prénom et un nom (pas trop court)
#- Une commande ne peut être passée que si:
#- il y a au moins un produit commandé
client1 = Client.create(firstname: "origin", lastname: "Master")



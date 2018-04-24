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

Product.cheap.each { |p| puts p }
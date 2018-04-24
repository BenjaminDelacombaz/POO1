require_relative "connection"
%w{client individual company product category order order_item supplier}.each {|file| require "./models/#{file}"}

#
# Main program
#

puts "Produits par fournisseurs"
puts "========================="

Supplier.all.each do |supplier|
  puts "#{supplier} a #{supplier.products.count} produits, un extrait: #{supplier.products.first(3).join(', ')}"
  puts "  ces categories: #{supplier.categories.join(', ')}"
end

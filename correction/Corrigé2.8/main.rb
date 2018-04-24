require_relative "connection"
%w{client individual company product category order order_item supplier comment}.each {|file| require "./models/#{file}"}

#
# Main program
#

happy = Company.first
happy.authored_comments.create(body: "Super produit!", target: Product.last)
Supplier.first.comments.create(body: "Super fournisseur!", author: happy)

angry = Individual.first
angry.authored_comments.create(body: "Evitez ce fournisseur!", target: Supplier.last)
Product.first.comments.create(body: "Fuyez ce produit!", author: angry)

puts "\nCommentaires de #{happy}"
puts "========================"
happy.authored_comments.each do |comment|
  puts "Concerne: #{comment.target}\n  #{comment.body}"
end

puts "\nCommentaires de #{angry}"
puts "========================"
angry.authored_comments.each do |comment|
  puts "Concerne: #{comment.target}\n  #{comment.body}"
end

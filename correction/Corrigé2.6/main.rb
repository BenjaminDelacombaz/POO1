require_relative "connection"
%w{client individual company product order order_item}.each {|file| require "./models/#{file}"}

#
# Main program
#

tricatel = Company.find_or_create_by name: 'Tricatel'
duchemin = Individual.find_or_create_by(lastname: 'Duchemin') {|user| user.firstname = 'Charles' }

puts "Les entreprises"
puts "==============="
puts Company.all
puts

puts "Les particuliers"
puts "================"
puts Individual.all
puts

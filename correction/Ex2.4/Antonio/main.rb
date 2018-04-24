require_relative 'connection'


#
# Programme principal
#
#
# product1 = Product.create name: "pomme", description: "Fruit du pommier", price: "7.70", categories: [category1]
# product2 = Product.create name: "banane", description: "Fruit du bananier", price: "12", categories: [category1]
# product3 = Product.create name: "carotte", description: "legume du carottier", price: "4.40", categories: [category2]
# client1 = Client.create(firstname: "Antonio", lastname: "Girodano")
# client2 = Client.create(firstname: "Julien", lastname: "Dupont")
# category1 = Category.create(name: "Fruits", description: "Some juicy fruts")
# category2 = Category.create(name: "Legumes", description: "Some pas bon les legumes")



require_relative 'Models/Client'
require_relative 'Models/Order'
require_relative 'Models/OrderItem'
require_relative 'Models/Product'
require_relative 'Models/Category'

# Product.cheap.each {|p| puts p}
OrderItem.bulk(50).map {|oi| oi.product}

















require_relative 'connection.rb'

require_relative 'Models/category'
require_relative 'Models/client'
require_relative 'Models/order'
require_relative 'Models/order_item'
require_relative 'Models/product'

# Exigence 2

#cli1 = Client.create firstname: 'Bernard', lastname: 'Oui'

#order = Order.create(client: cli1)
#order.order_items.build quantity: 2, item_price: 3.5, product: Product.find(2)

#cat1 = Category.create name: 'Les machins', description: 'Non'
#Product.create name: 'Chaussure trouée', price: 1, description: 'C bi1', category_id: 1

#puts order.order_items.count()


#Exigence 3

#puts Product.cheap

#Order_item.create quantity: 2394, item_price: 10, order_id: 1, product_id: 1
#Order_item.create quantity: 2, item_price: 10, order_id: 1, product_id: 1

puts Order_item.bulk
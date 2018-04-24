require_relative '../connection'
require_relative '../Models/category'
require_relative '../Models/client'
require_relative '../Models/order_item'
require_relative '../Models/order'
require_relative '../Models/product'

client1 = Client.create(firstname: "Jean", lastname: "Dujardin")
client2 = Client.create(firstname: "Marc", lastname: "Haut")
client3 = Client.create(firstname: "Pierra", lastname: "Feu")

#
# Category
#

category1 = Category.create(name: "Fleures", description: "Belles fleures montées en salade")
category2 = Category.create(name: "Pains", description: "Pain de qualité XXL+")
category3 = Category.create(name: "Vêtements", description: "Tout nu, tu pu")


#
# Products
#

product1 = Product.create(name: "tulipes", price: "100", description: "Une grosse grosse tulipe")
product2 = Product.create(name: "Short", price: "25", description: "Pas besoin de te dire la taille")
product3 = Product.create(name: "Breadcrumb", price: "50", description: "tmtc")

#order_item1 = OrderItem.create(quantity: "25", item_price: "25" order_id: "1", product_id: "1")
#order = Order.create(created_at: "", shipped_at: "" status: "mangé", client_id: "1")
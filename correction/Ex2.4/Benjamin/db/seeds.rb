require_relative '../connection'
require_relative '../models/client'
require_relative '../models/product'
require_relative '../models/category'
require_relative '../models/order'
require_relative '../models/order_item'


# Create clients
new_client = Client.create(firstname: 'Bernard', lastname: 'Margouille')
new_client2 = Client.create(firstname: 'Marcel', lastname: 'Liota')
new_client3 = Client.create(firstname: 'Fabien', lastname: 'Carlotta')
new_client4 = Client.create(firstname: 'Sullyvan', lastname: 'Butoxx')

# Create categories
new_category = Category.create(name: 'Audio', description: 'Pour les pros et les amateurs')
new_category2 = Category.create(name: 'Video', description: 'Pour les pros et les amateurs')

# Create products
new_product = Product.create(name: 'Casque sans fil Sony', price: 125, description: 'Très bon produit', categories: [new_category, new_category2])
new_product2 = Product.create(name: 'Câble HDMI 12m', price: 1500, description: 'Très bon produit', categories: [new_category2])
new_product3 = Product.create(name: 'Câble VGA 156m', price: 2684.25, description: 'Très bon produit', categories: [new_category2])
new_product4 = Product.create(name: 'Câble Jack vers Jack', price: 10, description: 'Très bon produit', categories: [new_category])

# Create some orders
new_order = Order.create(created_at: Date.today, shipped_at: nil, status: 1, client: new_client3)
new_order2 = Order.create(created_at: Date.today, shipped_at: nil, status: 2, client: new_client2)
new_order3 = Order.create(created_at: Date.today, shipped_at: nil, status: 1, client: new_client4)

# Create some orders items
new_order.order_items.create(quantity: 5, item_price: new_product3.price, product: new_product3)
new_order3.order_items.create(quantity: 150, item_price: new_product4.price, product: new_product4)
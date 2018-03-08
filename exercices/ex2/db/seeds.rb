require_relative '../connection'
require_relative '../models/client'
require_relative '../models/product'
require_relative '../models/category'
require_relative '../models/order'
require_relative '../models/order_item'
require_relative '../models/particular'
require_relative '../models/company'
require_relative '../models/supplier'
require_relative '../models/comment'


# Create clients
new_client = Particular.create(firstname: 'Bernard', lastname: 'Margouille')
new_client2 = Particular.create(firstname: 'Marcel', lastname: 'Liota')
new_client3 = Particular.create(firstname: 'Fabien', lastname: 'Carlotta')
new_client4 = Company.create(firstname: 'Sullyvan', lastname: 'Butoxx')

# Create some Supplier
new_supplier = Supplier.create(name: 'Digitec')
new_supplier2 = Supplier.create(name: 'Microspot')
new_supplier3 = Supplier.create(name: 'Galaxus')
new_supplier4 = Supplier.create(name: 'Steg')
new_supplier5 = Supplier.create(name: 'Ebay')

# Create categories
new_category = Category.create(name: 'Audio', description: 'Pour les pros et les amateurs')
new_category2 = Category.create(name: 'Video', description: 'Pour les pros et les amateurs')

# Create products
new_product = Product.create(name: 'Casque sans fil Sony', price: 125, description: 'Très bon produit', categories: [new_category, new_category2], supplier: new_supplier4, stock: 1548)
new_product2 = Product.create(name: 'Câble HDMI 12m', price: 1500, description: 'Très bon produit', categories: [new_category2], supplier: new_supplier2, stock: 5)
new_product3 = Product.create(name: 'Câble VGA 156m', price: 2684.25, description: 'Très bon produit', categories: [new_category2], supplier: new_supplier, stock: 4)
new_product4 = Product.create(name: 'Câble Jack vers Jack', price: 10, description: 'Très bon produit', categories: [new_category], supplier: new_supplier, stock: 25)

# Create some orders
new_order = Order.new(created_at: Date.today, shipped_at: nil, status: 1, client: new_client3)
# new_order2 = Order.new(created_at: Date.today, shipped_at: nil, status: 2, client: new_client2)
new_order3 = Order.new(created_at: Date.today, shipped_at: nil, status: 1, client: new_client4)

# Create some orders items
new_order.order_items.build(quantity: 5, product: new_product3)
new_order3.order_items.build(quantity: 150, product: new_product4)
new_order.save
new_order3.save

# Create some comments
new_comment = Comment.create(content: 'Super produit', commentable: new_supplier3, client: new_client4)
new_comment2 = Comment.create(content: 'Yes, merci', commentable: new_product3, client: new_client2)

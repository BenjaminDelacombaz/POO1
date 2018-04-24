%w{Client Category Order OrderItem Product}.each { |i| require_relative "../Models/#{i}" }

# Create a new user
user = Client.new
user.firstname = 'John'
user.lastname = 'Doe'
user.save

# Create product and category
category = Category.new
category.name = 'Calculators'
category.description = "Calculators for math lesson !"
category.save

p1 = Product.create(name: 'TInSpire CAS', description: "The best calculator !", price: 175)
p2 = Product.create(name: 'Nesspreso coffee', description: "For the break time", price: 175)
p3 = Product.create(name: 'Stylo bille', description: "For the break time", price: 12)

# Asociate category to product
ti = Product.where(name: 'TInSpire CAS').first
ti.categories << category
ti.save

# Create a order and add it to the user
order = Order.new
order.status = 1
order.client = user

# Add products to orders
order.order_items.build(quantity: 60, item_price: ti.price, product: ti)
order.order_items.build(quantity: 30, item_price: p2.price, product: p2)
order.order_items.build(quantity: 60, item_price: p3.price, product: p3)
order.save

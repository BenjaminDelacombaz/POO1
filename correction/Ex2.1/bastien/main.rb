require_relative 'connection'

require_relative 'Models/client'
require_relative 'Models/Order'
require_relative 'Models/OrderItem'
require_relative 'Models/Product'
require_relative 'Models/Category'

#
# Programme principal
#

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

product = Product.new
product.name = 'TInSpire CAS'
product.description = "The best calculator !"
product.price = 175
product.save

# Asociate category to product
product.categories << category
product.save
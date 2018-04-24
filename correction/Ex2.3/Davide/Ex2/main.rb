require_relative 'connection'

require_relative 'Models/Client'
require_relative 'Models/Order'
require_relative 'Models/OrderItem'
require_relative 'Models/Product'
require_relative 'Models/Category'

#
# Programme principal
#

# Create a new user

prod = Product.new
b=Array.new
b=prod.cheap
puts b


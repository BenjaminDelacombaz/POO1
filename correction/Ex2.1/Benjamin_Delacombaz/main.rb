require_relative 'connection'
require_relative 'model/client'
require_relative 'model/product'
require_relative 'model/category'
require_relative 'model/order'
require_relative 'model/orderItem'

#
# Programme principal
#

# Create first client
newClient = Client.new
newClient.lastname = 'Margouille'
newClient.firstname = 'Bernard'
newClient.save

# Create first category
newCategory = Category.new
newCategory.name = 'Audio'
newCategory.description = 'Pour les pros et les amateurs'
newCategory.save

# Create first product
newProduct = Product.new
newProduct.name = 'Casque sans fil Sony'
newProduct.price = 125
newProduct.description = 'Très bon produit'
newProduct.category = newCategory
newProduct.save

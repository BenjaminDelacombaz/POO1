require_relative 'connection.rb'

require_relative 'Models\Category.rb'
require_relative 'Models\Client.rb'
require_relative 'Models\Order.rb'
require_relative 'Models\OrderItem.rb'
require_relative 'Models\Product.rb'

#
# Programme principal
#


## Client ##

myClient1 = Client.create(firstname: "Jean", lastname: "Dupond")
myClient2 = Client.create(firstname: "Michel", lastname: "Marchand")
myClient3 = Client.create(firstname: "René", lastname: "Betchen")

## Categorie ##

myCategorie1 = Categorie.create(name: "Fruits", description: "Fruits en vrac")
myCategorie2 = Categorie.create(name: "Légumes", description: "Légumes")
myCategorie3 = Categorie.create(name: "Féculents", description: "Pates, riz")

## Product ##
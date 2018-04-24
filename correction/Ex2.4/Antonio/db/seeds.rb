
require_relative '../Models/Client'
require_relative '../Models/Order'
require_relative '../Models/OrderItem'
require_relative '../Models/Product'
require_relative '../Models/Category'
Product.create(name: "Ski de pistes", description: "pour debutant", price: BigDecimal('327.50'))
Product.create name: "Ski de fond", description: "pour pro", price: BigDecimal('327.50')
Category.create name: "Fruits", description: "Some juicy fruts"
Category.create(name: "Legumes", description: "Some pas bon les legumes")
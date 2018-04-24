%w{client product order order_item category supplier}.each {|file| require "./#{file}"}

sport   = Category.create name: 'Sport'
pickles = Category.create name: 'Pickles'

crazy  = Supplier.create name: 'CrazySport'
xpress = Supplier.create name: 'Xepresso'

Product.create name: "Ski de pistes", description: "Pour débutants", price: BigDecimal('327.50'), category: sport, supplier: crazy
Product.create name: "Ski de fonds", description: "Pour les endurants", price: BigDecimal('99.95'), category: sport, supplier: crazy
Product.create name: "Gants", description: "One size", price: BigDecimal('19.50'), category: sport, supplier: xpress
Product.create name: "Carambar", price: BigDecimal('0.20'), category: pickles, supplier: xpress
Product.create name: "Chiclette", price: BigDecimal('0.10'), category: pickles, supplier: xpress

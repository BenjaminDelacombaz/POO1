%w{client product order order_item}.each {|file| require_relative "../Models/#{file}" }

Product.create name: "Ski de pistes", description: "Pour débutants", price: BigDecimal('372.50')
Product.create name: "Ski de fonds", description: "Pour les endurants", price: BigDecimal('99.50')
Product.create name: "Gants", description: "One size", price: BigDecimal('19.50')
Product.create name: "Carambar", price: BigDecimal('0.20')
Product.create name: "Chiclette", price: BigDecimal('0.10')

Client.create firstname: 'Pascal', lastname: 'Hurni'
Client.create firstname: 'Xavier', lastname: 'Carrel'
Client.create firstname: 'Jérome', lastname: 'Chevillat'
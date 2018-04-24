require_relative '../Models/category'
require_relative '../Models/client'
require_relative '../Models/order'
require_relative '../Models/order_item'
require_relative '../Models/product'

## Add data in DB ##

## Client ##

my_client_1 = Client.create!(firstname: "Jean", lastname: "Dupond")
my_client_2 = Client.create!(firstname: "Michel", lastname: "Marchand")
my_client_3 = Client.create!(firstname: "René", lastname: "Betchen")

## Categorie ##

my_categorie_1 = Categorie.create!(name: "Fruits", description: "Fruits en vrac")
my_categorie_2 = Categorie.create!(name: "Légumes", description: "Légumes")
my_categorie_3 = Categorie.create!(name: "Féculents", description: "Pates, riz")

## Product ##

my_product_1 = Product.create!(name: "Ananas", price: 5.90, description: "origine afrique")
my_product_2 = Product.create!(name: "Pomme de terre", price: 1.85, description: "origine Suisse")
my_product_3 = Product.create!(name: "Pomme", price: 0.35, description: "origine France")

## Order ##

my_order_1 = Order.create!(created_at: Date.new(2018,2,3), shipped_at: Date.new(2018,3,4), status: 2, client: my_client_1)
my_order_2 = Order.create!(created_at: Date.new(2017,2,3), shipped_at: Date.new(2017,3,4), status: 1, client: my_client_1)
my_order_3 = Order.create!(created_at: Date.new(2018,1,1), shipped_at: Date.new(2018,2,1), status: 3, client: my_client_2)

my_order_1.order_items.build(quantity: 2, item_price: my_product_1.price, product: my_product_1)
my_order_1.save

my_order_2.order_items.build(quantity: 3, item_price: my_product_3.price, product: my_product_3)
my_order_2.save
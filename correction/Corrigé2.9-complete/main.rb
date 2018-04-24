require_relative "connection"
%w{client individual company product category order order_item supplier comment}.each {|file| require "./models/#{file}"}

#
# Observer setup
#

require 'rails/observers/activerecord/active_record'
require './stock_reducer'
require './stock_notifier'
require './notifier'

ActiveRecord::Base.observers << StockReducer << StockNotifier
ActiveRecord::Base.instantiate_observers

#
# Main program
#

order = Client.first.orders.build

order.order_items.build(product: Product.first, quantity: 2)
order.order_items.build(product: Product.first, quantity: 3)
order.order_items.build(product: Product.last, quantity: 4)

if order.save
  # Okay, now change status to shipping
  order.status = "shipping"
  order.save!
else
  puts order.errors.full_messages
  puts order.order_items.map {|item| item.errors.full_messages}.join("\n")
end

require_relative 'bookable_item'

class Vehicle < BookableItem
  has_one :manual, as: 'item'
end

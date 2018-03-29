require_relative 'bookable_item'

class Equipment < BookableItem
  has_and_belongs_to_many :responsibles, class_name: 'User', join_table: 'equipment_responsibles'
end

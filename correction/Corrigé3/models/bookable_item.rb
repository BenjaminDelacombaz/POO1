class BookableItem < ActiveRecord::Base
  has_and_belongs_to_many :bookings, join_table: 'bookings_items'
  has_and_belongs_to_many :groups
  
  def to_s
    name
  end
  
  def available?(starts_at, ends_at)
    bookings.between(starts_at, ends_at).empty?
  end
end

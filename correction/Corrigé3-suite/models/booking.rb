require_relative 'event'

class Booking < Event
  has_and_belongs_to_many :items, class_name: 'BookableItem', join_table: 'bookings_items'
  
  validate :items_availability, if: ->(booking) { booking.starts_at && booking.ends_at}
  validate :group_ownership, if: ->(booking) { booking.created_by }
  
  def participants
    super | items.map {|item| item.respond_to?(:responsibles) ? item.responsibles : []}.flatten.compact.uniq
  end

  protected
  
  def items_availability
    items.each do |item|
      errors.add(:items, "#{item} is not available between #{starts_at} and #{ends_at}") unless item.available?(starts_at, ends_at)
    end
  end
  
  def group_ownership
    errors.add(:items, "are not bookable by #{created_by}") if (items.map(&:groups).flatten & created_by.groups).empty?
  end
end

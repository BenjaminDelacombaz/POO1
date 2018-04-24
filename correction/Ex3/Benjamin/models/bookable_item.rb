class BookableItem < ActiveRecord::Base
  has_and_belongs_to_many :bookings, join_table: 'bookings_items'
  has_and_belongs_to_many :groups
  
  # Scope for view bookable items without booking
  scope :items_without_booking, -> { left_outer_joins(:bookings).where( events: { id: nil } ) }

  # Scope for view bookable items in a date
  scope :reserved_items, -> (date) { joins(:bookings).where('YEAR(starts_at) >= ?', date).where('YEAR(ends_at) <= ?', date) }

  def to_s
    name
  end
  
  def available?(starts_at, ends_at)
    bookings.between(starts_at, ends_at).empty?
  end

  def self.have_reservation? date
    self.reserved_items(date).any?
  end

  def used_by
    participants = Array.new
    bookings.each { |booking| participants.push(booking.participants).uniq}
    participants
  end
end

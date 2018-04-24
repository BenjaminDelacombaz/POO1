#
# POO1: Ex3: events and bookings system
#

# Load all the parts
require 'rubygems'
require 'active_record'
require 'rails/observers/activerecord/active_record'
require './db'
require './mailer'

Dir.glob("./models/**/*.rb").each {|file| require file}
Dir.glob("./observers/**/*.rb").each {|file| require file; ActiveRecord::Base.observers << File.basename(file, '.*') }

# Setup logger (so that we may inspect the generated SQL)
require 'logger'
LOGGER = Logger.new(File.open('ar.log', 'w'))

# Tie parts to ActiveRecord
ActiveSupport::LogSubscriber.colorize_logging = false
ActiveRecord::Base.logger = LOGGER
ActiveRecord::Base.instantiate_observers

# Prepare DB
DB.connect
DB.truncate
DB.seed

#
# Some testing facilities
#

def test(title)
  puts "\n### #{title}"
  yield
rescue
  puts "EXCEPTION: #{$!.message}"
end

def fail(message)
  puts "FAILED: #{message}"
end

#
# Main app
#

NOW = Time.now

test "Creating invalid event" do
  event = Event.create title: "some event", starts_at: NOW
  puts event.errors.full_messages
end

test "Creating simple event" do
  Event.create! title: "Simple event", starts_at: NOW, ends_at: NOW + 1.hour, created_by: User.first
end

test "Creating event with participants" do
  event = Event.create! title: "Bar Mitzvah", starts_at: NOW, ends_at: NOW + 1.hour,
    created_by:  User.find_by(:firstname => 'Lucky'),
    created_for: User.find_by(:firstname => 'Jolly'),
    attendees:   User.where(:lastname => 'Dalton')
  
  fail "attendees mismatch" if event.attendees != User.where(lastname: 'Dalton')
end

test "Creating overlapping event" do
  event = Event.create! title: "Hanging", starts_at: NOW + 30.minutes, ends_at: NOW + 2.hours,
    created_by: User.find_by(firstname: 'Lucky'),
    attendees:  User.where(lastname: 'Dalton')
    
  puts "Events for the next 2 hours:"
  puts Event.between(NOW, NOW+2.hours).map {|event| "#{event.title} #{event.starts_at} #{event.ends_at}"}
end

test "Updating an event" do
  event = Event.last
  event.starts_at = NOW + 2.hours
  event.ends_at = NOW + 3.hours
  event.attendees.delete User.find_by(firstname: 'Joe')
  event.save!
end

test "Destroying an event" do
  Event.last.destroy
end

# Bookings

test "Creating invalid booking" do
  event = Booking.create title: "some booking", starts_at: NOW
  puts event.errors.full_messages
end

test "Creating a booking without items" do
  Booking.create! title: "Simple booking", starts_at: NOW, ends_at: NOW + 1.hour, created_by: User.first
end

test "Creating a single item booking" do
  Booking.create! title: "Mini fiesta", starts_at: NOW, ends_at: NOW + 5.hour,
    created_by: User.find_by(firstname: 'Joe'),
    items: [Room.find_by(name: 'Saloon')]
end

test "Creating an overlapping booking" do
  Booking.create! title: "Other fiesta", starts_at: NOW, ends_at: NOW + 1.hour,
    created_by: User.find_by(firstname: 'Lucky'),
    items: [Room.find_by(name: 'Saloon')]
end

test "Creating a booking with equipment" do
  Booking.create! title: "Lynching", starts_at: NOW + 2.hours, ends_at: NOW + 3.hours,
    created_by: User.find_by(firstname: 'Lucky'),
    items: Equipment.all
  puts "Mail should have been sent to Jolly Jumper as well (responsible for some equipment)"
end

test "Creating a booking with forbidden items" do
  Booking.create! title: "Lynching", starts_at: NOW + 2.hours, ends_at: NOW + 3.hours,
    created_by: User.find_by(firstname: 'Averell'),
    items: Equipment.all
end

test "Delete emtpy groups" do
  groups = Group.delete_empty_groups!
  puts "This groups: #{groups} has been deleted"
end

test "Show bookable items without booking" do
  items = BookableItem.items_without_booking
  puts "This bookable items: #{items.each {|item|}} doesn't have a booking"
end

test "Show bookable items reserved today" do
  items = BookableItem.reserved_items(NOW)
  puts "This bookable items: #{items.each {|item|}} is booked today"
end

test "Date have reservation ?" do
  puts "Today have reservation ? #{BookableItem.have_reservation?(NOW)}"
  puts "2017-01-01 have reservation ? #{BookableItem.have_reservation?('2018-01-01')}"
end

test "Longest duration event" do
  puts "The longest event is : #{Event.longest_duration.first}"
end

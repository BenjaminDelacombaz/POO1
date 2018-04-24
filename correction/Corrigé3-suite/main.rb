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
# Add some more records
#

NOW = Time.now

Event.create! title: "Simple event", starts_at: NOW, ends_at: NOW + 1.hour, created_by: User.first

Event.create! title: "Bar Mitzvah", starts_at: NOW, ends_at: NOW + 1.hour,
  created_by:  User.find_by(:firstname => 'Lucky'),
  created_for: User.find_by(:firstname => 'Jolly'),
  attendees:   User.where(:lastname => 'Dalton')

Event.create! title: "Hanging", starts_at: NOW + 30.minutes, ends_at: NOW + 2.hours,
  created_by: User.find_by(firstname: 'Lucky'),
  attendees:  User.where(lastname: 'Dalton')

Booking.create! title: "Ceremony", starts_at: NOW, ends_at: NOW + 2.hour,
  created_by: User.find_by(firstname: 'Lucky'),
  items: [Room.find_by(name: 'Church')]

Booking.create! title: "Mini fiesta", starts_at: NOW, ends_at: NOW + 1.hour,
  created_by: User.find_by(firstname: 'Lucky'),
  items: [Room.find_by(name: 'Saloon')]

Booking.create! title: "Another fiesta", starts_at: NOW+2.hours, ends_at: NOW + 2.5.hour,
  created_by: User.find_by(firstname: 'Lucky'),
  items: [Room.find_by(name: 'Saloon')]

Booking.create! title: "Lynching", starts_at: NOW + 2.hours, ends_at: NOW + 5.hours,
  created_by: User.find_by(firstname: 'Lucky'),
  items: Equipment.all,
  attendees:  User.where(lastname: 'Dalton')

Group.create! name: 'None'
Group.create! name: 'Empty'


#
# 1. Afficher la réservation la plus longue (durée de réservation)
#

puts "\n1. Afficher la réservation la plus longue (durée de réservation)"

longest = Booking.order_by_duration(:desc).first
puts "#{longest.title} #{longest.duration/3600} hours"


#
# 2. Afficher les items sans réservations
#

puts "\n2. Afficher les items sans réservations"

# Solution 1
puts BookableItem.without_bookings

# Solution 2 (moins bonne)
puts BookableItem.all - Booking.includes(:items).flat_map(&:items)
# ou
puts BookableItem.all - BookableItem.joins(:bookings)
# ou
puts BookableItem.where.not(id: BookableItem.joins(:bookings))


#
# 3. Afficher tous les utilisateurs ayant participé à des réservations d'un item particulier
#

puts "\n3. Afficher tous les utilisateurs ayant participé à des réservations d'un item particulier"

item = BookableItem.find_by(name: 'Tar')

# Cette ligne est très "compacte", elle est équivalente à ces variantes:
# 1. participants = item.bookings.map {|booking| booking.participants}.flatten.uniq
# 2. participants = item.bookings.map(&:participants).flatten.uniq
participants = item.bookings.flat_map(&:participants).uniq

puts "For #{item}: #{participants.join(', ')}"


#
# 4. Supprimer les groupes sans utilisateurs
#
# http://andreigridnev.com/empty-blank-any-exists-methods-of-ruby-on-rails-activerecord/

puts "\n4. Supprimer les groupes sans utilisateurs"

puts "Groups without users: #{Group.empty.join(', ')}"

# Solution 1
Group.empty.destroy_all

# Solution 2 (moins bonne)
Group.all.each {|group| group.destroy unless group.users.exists? }


#
# 5. Déterminer s'il y a des réservations ou non à une date donnée
#

puts "\n5. Déterminer s'il y a des réservations ou non à une date donnée"

puts "Booking at #{NOW}? #{Booking.at(NOW).empty? ? 'no' : 'yes'}"
puts "Booking at #{NOW+4.hours}? #{Booking.at(NOW+4.hours).empty? ? 'no' : 'yes'}"
puts "Booking at #{NOW+6.hours}? #{Booking.at(NOW+6.hours).empty? ? 'no' : 'yes'}"

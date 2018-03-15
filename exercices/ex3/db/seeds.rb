require_relative '../connection'
require_relative '../models/user'
require_relative '../models/group'
require_relative '../models/event'
require_relative '../models/room'
require_relative '../models/vehicle'

# Create some groups
group1 = Group.create(name: 'Admin')
group2 = Group.create(name: 'Reservation')
group3 = Group.create(name: 'Event')

# Create some users
user1 = User.create(firstname: 'Bernard', lastname: 'Margouille', email: 'bernard.margouille@reservoxx.ch', groups: [group1, group3])
user2 = User.create(firstname: 'Marcel', lastname: 'Liota', email: 'marcel.liota@reservoxx.ch', groups: [group2, group3])
user3 = User.create(firstname: 'Fabien', lastname: 'Carlotta', email: 'fabien.carlotta@reservoxx.ch', groups: [group3])
user4 = User.create(firstname: 'Sullyvan', lastname: 'Butoxx', email: 'sullyvan.butoxx@reservoxx.ch', groups: [group1, group3])

#  Create some events
event1 = Event.create(name: 'Salon du vin', start: '2018-02-13 10:30:00', end: '2018-02-14 18:00:00', creator_user: user4, created_for_user: user1, users: [user2])
event2 = Event.create(name: 'Salon du pain', start: '2018-03-15 10:30:00', end: '2018-03-16 18:00:00', creator_user: user4, created_for_user: user2)
event3 = Event.create(name: 'Salon de la tortue', start: '2018-06-15 10:30:00', end: '2018-06-16 18:00:00', creator_user: user3, users: [user1, user2])

# Create some rooms
room1 = Room.create(name: 'Paris')
room2 = Room.create(name: 'Lisbonne')
room3 = Room.create(name: 'Denver')
room4 = Room.create(name: 'Moscow')
room5 = Room.create(name: 'Berlin')

# Create some vehicles
vehicle1 = Vehicle.create(name: 'Ford Ranger TDI 1.6', manual: "app/manuals/ford_ranger_tdi_1_6.pdf")
vehicle2 = Vehicle.create(name: 'Skoda Octavia', manual: "app/manuals/skoda_octavia.pdf")
vehicle3 = Vehicle.create(name: 'Fiat Panda 4x4', manual: "app/manuals/fiat_panda_4x4.pdf")
vehicle4 = Vehicle.create(name: 'Citroen C3 Picasso', manual: "app/manuals/citroen_c3_picasso.pdf")
vehicle5 = Vehicle.create(name: 'Peugeot 207 Break', manual: "app/manuals/peugeot_207_break.pdf")

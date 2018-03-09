require_relative '../connection'
require_relative '../models/user'
require_relative '../models/group'

# Create some groups
group1 = Group.create(name: 'Admin')
group2 = Group.create(name: 'Reservation')
group3 = Group.create(name: 'Event')

# Create some users
user1 = User.create(firstname: 'Bernard', lastname: 'Margouille', email: 'bernard.margouille@reservoxx.ch', groups: [group1, group3])
user2 = User.create(firstname: 'Marcel', lastname: 'Liota', email: 'marcel.liota@reservoxx.ch', groups: [group2, group3])
user3 = User.create(firstname: 'Fabien', lastname: 'Carlotta', email: 'fabien.carlotta@reservoxx.ch', groups: [group3])
user4 = User.create(firstname: 'Sullyvan', lastname: 'Butoxx', email: 'sullyvan.butoxx@reservoxx.ch', groups: [group1, group3])

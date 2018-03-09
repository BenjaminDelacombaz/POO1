require_relative '../connection'
require_relative '../models/user'


# Create clients
user1 = User.create(firstname: 'Bernard', lastname: 'Margouille', email: 'bernard.margouille@reservoxx.ch')
user2 = User.create(firstname: 'Marcel', lastname: 'Liota', email: 'marcel.liota@reservoxx.ch')
user3 = User.create(firstname: 'Fabien', lastname: 'Carlotta', email: 'fabien.carlotta@reservoxx.ch')
user4 = User.create(firstname: 'Sullyvan', lastname: 'Butoxx', email: 'sullyvan.butoxx@reservoxx.ch')

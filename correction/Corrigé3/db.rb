module DB
  extend self
  
  def connect
    ActiveRecord::Base.establish_connection(
      adapter:  'mysql2',
      host:     '127.0.0.1',
      username: 'root',
      password: '',
      database: 'poo1_events'
    )
  end
  
  def truncate
    ActiveRecord::Base.connection.tables.each {|table_name| ActiveRecord::Base.connection.execute("TRUNCATE #{table_name}") }
  end
  
  def seed
    # create users, groups and connect them
    joe     = User.create! firstname: 'Joe', lastname: 'Dalton', email: 'joe@dalton.com'
    averell = User.create! firstname: 'Averell', lastname: 'Dalton', email: 'averell@dalton.com'
    lucky   = User.create! firstname: 'Lucky', lastname: 'Luke', email: 'luke@theforce.com'
    jolly   = User.create! firstname: 'Jolly', lastname: 'Jumper', email: 'jolly@jumper.com'
    
    good = Group.create! name: 'The good'
    bad  = Group.create! name: 'The bad'
    ugly = Group.create! name: 'The ugly'
    
    good.users << lucky
    ugly.users << jolly
    bad.users << joe << averell
    
    # create bookable items with their respective customized datas
    dilly  = Vehicle.create! name: 'Diligence'
    hearse = Vehicle.create! name: 'Hearse'
    
    Manual.create!(title: 'How to drive a dilly', item: dilly, file_name: 'howtodrive.pdf')
    Manual.create!(title: 'RIP', item: hearse, file_name: 'rip.pdf')
    
    tar = Equipment.create! name: 'Tar'
    feather = Equipment.create! name: 'Feather'
    
    tar.responsibles << lucky
    feather.responsibles << jolly
    
    saloon = Room.create! name: 'Saloon'
    church = Room.create! name: 'Church'
    
    # setup bookable items groups
    dilly.groups   << good << bad << ugly
    hearse.groups  << bad
    tar.groups     << good
    feather.groups << ugly
    saloon.groups  << good << bad
    church.groups  << good << ugly
  end
end

require 'bundler'
Bundler.require
require 'rails/observers/activerecord/active_record'  
require_relative 'connection'
require_relative 'models/user'
require_relative 'models/group'
require_relative 'models/event'
require_relative 'models/room'
require_relative 'models/vehicle'
require_relative 'models/equipment'
require_relative 'models/reservation'
require_relative 'models/reserved_item'
require_relative 'observers/event_notifier'
require_relative 'notifier'

ActiveRecord::Base.observers += [:event_notifier]
ActiveRecord::Base.instantiate_observers

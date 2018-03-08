require_relative 'connection'
require_relative 'model/car'
require_relative 'model/engine'

#
# Programme principal
#

ActiveRecord::Base.connection.execute("SELECT 1")

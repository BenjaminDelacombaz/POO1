require_relative 'connection'

#
# Programme principal
#

ActiveRecord::Base.connection.execute("SELECT 1")

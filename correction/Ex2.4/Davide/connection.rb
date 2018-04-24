require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'mysql2',
  host:     'dvm',
  username: 'root',
  password: 'root',
  database: 'eCommerce'
)

# Setup logger (so that we may inspect the generated SQL)
require 'logger'
ActiveSupport::LogSubscriber.colorize_logging = false
ActiveRecord::Base.logger = Logger.new("ar.log")

class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
  
  # has_many :created_events, class_name: 'Event', foreign_key: 'created_by_id'
  
  def name
    "#{firstname} #{lastname}"
  end
  
  def to_s
    name
  end
end

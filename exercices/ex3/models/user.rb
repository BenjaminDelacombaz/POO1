class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_many :event_creation, :class_name => "Event", :foreign_key => :creator_user_id
  has_many :event_responsible, :class_name => "Event", :foreign_key => :created_for_user_id
  has_and_belongs_to_many :events
  has_and_belongs_to_many :equipment
  has_many :reservation_creation, :class_name => "Reservation", :foreign_key => :creator_user_id
  has_many :reservation_responsible, :class_name => "Reservation", :foreign_key => :created_for_user_id
  has_and_belongs_to_many :reservations

  validates :groups, presence: true

  def to_s
      "#{firstname} #{lastname}"
  end
end

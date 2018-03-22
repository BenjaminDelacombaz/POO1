class Reservation < ActiveRecord::Base
  belongs_to :creator_user, :class_name => "User"
  belongs_to :created_for_user, :class_name => "User"
  has_and_belongs_to_many :users
  has_many :reserved_items
  has_many :items, through: :reserved_items, source: :reservable
  has_many :equipments, through: :reserved_items, source: :reservable, source_type: 'Equipment'
  has_many :vehicles, through: :reserved_items, source: :reservable, source_type: 'Vehicle'

  def to_s
    "#{name}"
  end
end

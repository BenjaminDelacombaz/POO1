class Reservation < ActiveRecord::Base
  belongs_to :creator_user, :class_name => "User"
  belongs_to :created_for_user, :class_name => "User"
  has_and_belongs_to_many :users
  has_many :reserved_items

  def to_s
    "#{name}"
  end
end
class Reservation < ActiveRecord::Base
  belongs_to :creator_user, :class_name => "User"
  belongs_to :created_for_user, :class_name => "User"

  def to_s
    "#{name}"
  end
end
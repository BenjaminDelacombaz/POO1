class Event < ActiveRecord::Base
  belongs_to :creator_user, :class_name => "User"
  belongs_to :created_for_user, :class_name => "User"
  has_and_belongs_to_many :users


  def to_s
    "#{name}"
  end

  def participants
    (users + [created_for_user, creator_user]).compact.uniq
  end
end

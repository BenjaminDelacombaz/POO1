class Vehicle < ActiveRecord::Base
  has_many :reservations, as: :reservable
  
  def to_s
    "#{name}"
  end
end
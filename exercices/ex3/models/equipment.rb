class Equipment < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :reservations, as: :reservable
  
  
  def to_s
    "#{name}"
  end
end
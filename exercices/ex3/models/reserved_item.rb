class ReservedItem < ActiveRecord::Base
  belongs_to :reservable, polymorphic: true
  belongs_to :reservation

end

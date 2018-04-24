class Car < ActiveRecord::Base
  has_many :reservables, as: :reservable
  has_many :can_books, as: :can_book
  
  def free
    !self.reservables.exists?
  end
 end
class Supplier < ActiveRecord::Base
  has_many :products
  has_many :categories, -> { distinct }, through: :products
  has_many :comments, as: :target
  
  def to_s
    name
  end
end

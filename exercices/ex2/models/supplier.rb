class Supplier < ActiveRecord::Base
  has_many :products
  has_many :categories, -> { distinct }, through: :products
  has_many :comments, as: :commentable

  def to_s
    "#{name} Catégorie(s): #{categories.join(", ")}"
  end
end

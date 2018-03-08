class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :supplier
  has_many :comments, as: :commentable

  scope :cheap, -> { where('price < ?', 21) }

  def to_s
    "#{name}"
  end
end

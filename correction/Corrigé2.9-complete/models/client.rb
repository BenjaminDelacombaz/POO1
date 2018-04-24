class Client < ActiveRecord::Base
  has_many :orders
  has_many :ordered_products, lambda { distinct }, through: :orders, source: :products
  has_many :authored_comments, class_name: 'Comment', foreign_key: :author_id
  
  def to_s
    "#{firstname} #{lastname}"
  end
end

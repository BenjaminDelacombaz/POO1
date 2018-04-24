class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :order_item

  def to_s
    "#{name}"
  end

  scope :cheap, -> { where("price < ?", 30 ) }

end
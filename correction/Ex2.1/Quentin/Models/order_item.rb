class Order_item < ActiveRecord::Base
  belongs_to :order
  has_many :product

  def to_s
    "#{quantity}"
  end

  scope :bulk, -> { where("quantity >= ?", 100 ) }

end
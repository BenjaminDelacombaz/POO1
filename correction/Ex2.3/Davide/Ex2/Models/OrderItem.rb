class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  def to_s
      "#{quantity} #{product}"
  end
  scope : bulk, ->(number) {where()}
end
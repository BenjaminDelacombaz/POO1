class Client < ActiveRecord::Base
  has_many :orders
  #has_many :products, through: :orders
  has_many :ordered_products, -> { distinct }, through: :orders, source: :products

  validates :firstname, :lastname, presence: true,
            length: { minimum: 2 },
            uniqueness: true

  def to_s
    "#{firstname} #{lastname}"
  end
end
class Client < ActiveRecord::Base
  has_many :orders
  #aggiunto per poter creare nel main una requette un po piu bella
  #has_many :products, through: :orders
  # In questo caso diamo un nome alla relazione ma bisogna definire order_product con source
  has_many :ordered_products, ->{distinct}, through: :orders, source: :products

  def to_s
    "#{firstname} #{lastname}"
  end

  validates :firstname,
    presence: true,
    length: {minimum: 6}
  validates :lastname,
    presence: true,
    length: {minimum: 6}
end
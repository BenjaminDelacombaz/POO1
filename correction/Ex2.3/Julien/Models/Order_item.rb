class OrderItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :items
	
	scope :bulk,
		-> (quantity = 100){
		where('quantity >= ?', quantity)
		}
		
	def to_s
		"#{quantity}" "#{name}"
	end
end
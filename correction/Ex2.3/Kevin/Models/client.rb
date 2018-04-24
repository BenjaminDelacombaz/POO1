class Client < ActiveRecord::Base
    has_many :orders

    def to_s
        "#{firstname} #{lastname}"
    end

end
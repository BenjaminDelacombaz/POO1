class Individual < Client
  validates :firstname, :lastname,
    presence: true,
    length:   {minimum: 3}
  
  def to_s
    "#{firstname} #{lastname}"
  end
end

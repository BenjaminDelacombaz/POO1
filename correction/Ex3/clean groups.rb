  def clean
    unless self.users.exists?
      self.delete
    end
  end
  
class Group < ActiveRecord::Base
  
  def self.empty_delete
    egs = self.all.reject { |g| g.users.any? }
    egs.map { |g| g.destroy }
  end

end
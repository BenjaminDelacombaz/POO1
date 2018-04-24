class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  ### For 4.
  # Returns empty groups, groups that have no users
  scope :empty, -> { left_joins(:users).where(users: {id: nil}) }
  
  def to_s
    name
  end
end
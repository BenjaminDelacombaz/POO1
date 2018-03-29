class Group < ActiveRecord::Base
  has_and_belongs_to_many :users

  # Scope for view empty groups
  scope :empty_groups, -> { left_outer_joins(:users).where( users: { id: nil } ) }


  # Static function for delete empty groups from the DB
  def self.delete_empty_groups!
    Group.empty_groups.each {|group| group.destroy! }
  end
end
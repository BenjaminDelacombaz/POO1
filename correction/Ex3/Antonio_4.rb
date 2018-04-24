scope :empty_groups, -> { left_outer_joins(:users).where( users: { id: nil } ) }

  def self.delete_empty_groups!
    Group.empty_groups.each {|group| group.destroy! }
  end
class Event < ActiveRecord::Base
  belongs_to :created_by,  class_name: 'User'
  belongs_to :created_for, class_name: 'User'
  has_and_belongs_to_many :attendees, class_name: 'User', after_remove: :track_removed_attendee
  
  validates :title, :starts_at, :ends_at, :created_by, presence: true
  validate :time_lapse, if: ->(booking) { booking.starts_at && booking.ends_at}

  scope :between, proc {|start, stop| where(['starts_at < :stop AND ends_at > :start', start.is_a?(Range) ? {start: start.begin, stop: start.end} : {start: start, stop: stop}]) }
  
  def participants
    (attendees + [created_by, created_for]).compact
  end
  
  def removed_attendees
    @removed_attendees ||= []
  end

  ### For 1.
  def self.order_by_duration(direction = :asc)
    order("(ends_at - starts_at) #{direction == :desc ? 'DESC' : 'ASC'}")
  end
  
  def duration
    ends_at - starts_at
  end
  ###
  
  ### For 5.
  def self.at(time)
    between(time, time)
  end
  ###
  
  protected
  
  def time_lapse
    errors.add(:ends_at, "must be after start date") if ends_at < starts_at
  end
  
  def track_removed_attendee(attendee)
    removed_attendees << attendee
  end
end

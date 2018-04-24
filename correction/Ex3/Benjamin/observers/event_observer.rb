class EventObserver < ActiveRecord::Observer
  observe :event
  
  def after_create(event)
    Mailer.deliver_mail event.participants, "New #{human_event_type(event)} #{event.id}",
      event_body(event) <<
      format_attendees('Attendees', event.attendees)
  end
  
  def after_update(event)
    Mailer.deliver_mail event.participants|event.removed_attendees, "#{human_event_type(event).titleize} #{event.id} modifications",
      event_body(event) <<
      format_attendees('Removed attendees', event.removed_attendees) <<
      format_attendees('Current attendees', event.attendees)
  end
  
  def before_destroy(event)
    Mailer.deliver_mail event.participants, "Removing #{human_event_type(event)} #{event.id}",
      event_body(event) <<
      format_attendees('Attendees', event.attendees)
  end
  
  protected
  
  def human_event_type(event)
    {Event => 'event', Booking => 'booking'}[event.class]
  end
  
  def event_body(event)
    <<-EOS
Title: #{event.title}
Created by : #{event.created_by}#{event.created_for ? "\nCreated for: #{event.created_for}" : ''}
Starts at: #{event.starts_at}
Ends at  : #{event.ends_at}
#{event.respond_to?(:items) ? "Items: #{event.items.map(&:name).join(', ')}" : ''}
EOS
  end
  
  def format_attendees(title, attendees)
    attendees.empty? ? '' : "\n#{title}:\n" << attendees.map {|attendee| "  #{attendee}"}.join("\n")
  end
end
class EventNotifier < ActiveRecord::Observer
  observe :event, :reservation

  def after_create(record)
    case record
      when Event
        Notifier.notify('console', record.participants, "Un nouvel #{record.class.to_s.downcase} vient d'être créé.")
      when Reservation
        Notifier.notify('console', "Une nouvelle #{record.class.to_s.downcase} vient d'être créée.")
      else
        Notifier.notify('console', "Un nouveau truc à été créé.")
    end
  end

  def after_update(record)
    case record
      when Event
        Notifier.notify('console', "Une mise à jour d'un #{record.class.to_s.downcase} vient d'être effectué.")
      when Reservation
        Notifier.notify('console', "Une mise à jour d'une #{record.class.to_s.downcase} vient d'être effectuée.")
      else
        Notifier.notify('console', "Un mise à jour d'un truc vient d'être effectué.")
    end
  end

  def after_destroy(record)
    case record
      when Event
        Notifier.notify('console', "Un #{record.class.to_s.downcase} vient d'être supprimé.")
      when Reservation
        Notifier.notify('console', "Une #{record.class.to_s.downcase} vient d'être supprimée.")
      else
        Notifier.notify('console', "Un truc vient d'être supprimé.")
    end
  end
end

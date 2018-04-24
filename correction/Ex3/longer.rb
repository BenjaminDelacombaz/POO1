max = 0
longer = nil
Reservation.all.each do |r|
  if r.duration > max
    max = r.duration
    longer = r
  end
end
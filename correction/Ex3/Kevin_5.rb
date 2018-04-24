def self.reserved(date)
  self.all.each do |r|
    range = r.start.to_i..r.finish.to_i
    if range === date.to_i
      return "Occupé"
    end
  end
  return "Libre"
end
class Notifier
  def self.notify(format, target, message)
    case format
    when 'console'
      puts target
      puts message
    else
    puts 'Format non gérée'
    end
  end
end

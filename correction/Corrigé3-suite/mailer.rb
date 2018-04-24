class Mailer
  FROM = "noreply@cpnv.ch"
  
  def self.deliver_mail(recipients, subject, body)
    recipients = Array(recipients)
    emails = if recipients.first.respond_to? :email
      recipients.first.respond_to?(:name) ? recipients.map {|recipient| "#{recipient.name} <#{recipient.email}>" } : recipients.map(&:email)
    else
      recipients
    end
    
    LOGGER.info "Sending mail '#{subject}' to #{emails}\n#{body}"
  end
end

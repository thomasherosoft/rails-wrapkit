class UserMailer < ApplicationMailer
  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(from: "admin@example.com",
         to: 'test@example.com',
         subject: 'New Visitor\'s Email')
  end
end
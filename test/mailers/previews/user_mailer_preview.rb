# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def welcome_email # le système de preview n'a pas d'argument car il appelle une méthode qui appelle elle-même des arguments
    UserMailer.welcome_email(user)
  end

end

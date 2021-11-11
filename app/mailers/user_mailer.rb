class UserMailer < ApplicationMailer
 
  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://eventbrite-app-kl.herokuapp.com/sign_in' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: "Bienvenue sur Eventbrite ! 🙌") 
  end

  def new_order_email(attendance)
    @event = attendance.event
    @customer = attendance.customer
    @url  = 'http://eventbrite-app-kl.herokuapp.com/events/#{@event.id}' 
    mail(to: @event.admin.email, subject: "Nouvelle participation à l'événement #{@event.title} 🎉"
    )
  end

  def order_validation_email(user, event)
    @user = user
    @event = event
    @url = 'http://eventbrite-app-kl.herokuapp.com/events/#{@event.id}'
    mail(to: @user.email, subject: "Vous êtes inscrit à un event !")
  end

    # en production avec une API d'un email sender
    # 1. verify sender adress sur le compte
    # 2. puis changer le default from de user_mailer.rb avec cette bonne adresse via ajout d'un ENV['EMAIL_FROM'] = sender_email dans le fichier .env 
    # >>> mail(from: ENV['EMAIL_FROM'], to: @user.email, subject: 'Bienvenue !')

end

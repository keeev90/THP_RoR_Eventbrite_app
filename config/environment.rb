# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

##### /!\ ACTION MAILER EN PRODUCTION ####
# 1. paramétrer le SMTP avec les infos de SendGrid (par exemple) qui seront récupérées par Heroku
ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_LOGIN'],
  :password => ENV['SENDGRID_PWD'],
  :domain => 'eventbrite-app-kl.herokuapp.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

# 2. Passer les clefs d'APIs à HEROKU >>> https://devcenter.heroku.com/articles/config-vars

# 3. Tester l'envoi directement depuis l'environnement de développement (ton ordi)
# Enlève la ligne config.action_mailer.delivery_method = :letter_opener du fichier config/environments/development.rb ;
# Va dans ta console Rails ;
# Créé un utilisateur avec une adresse en @yopmail.com (habituées à servir de poubelle et du coup cela évite que les emails de tests soient considérés comme du spam et tout simplement rejetés par la majorité des serveurs e-mails)
# Va vérifier que l’e-mail est bien arrivé sur http://www.yopmail.com/.

# 4. Envoyer deouis un domaine propriétaire >>> cf ligne SMTP settings à mettre à jour ":domain => 'monsite.fr'  

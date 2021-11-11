class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end

# en production avec un SMTP fonctionnel : default from: ENV['EMAIL_FROM'] avec réf dans le fichier .env
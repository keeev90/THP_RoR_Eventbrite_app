class ApplicationController < ActionController::Base
  include UsersHelper # inclure dans tous les controllers le helper "UsersHelper" créé dans le fichier app/helpers/sessions_helper.rb
  include AttendancesHelper
  helper_method :current_user
end

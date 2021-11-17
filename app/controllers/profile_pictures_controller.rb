class ProfilePicturesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id]) # identifier l'utilisateur concerné
    @user.profile_picture.attach(params[:profile_picture]) # attriber le fichier dont la référence est contenue dans params[:nom_du_fichier]
    flash[:success] = "L'image a bien été ajoutée."
    redirect_to(user_path(@user)) # redirection vers la page show du user
  end
end

module UsersHelper

  # restreindre l'accès au user concerné (page profil)
  def is_permitted_user?
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:danger] = "Vous n'êtes pas autorisé(e) à accéder à cette page"
      redirect_to root_path
    end
  end

  # restreindre l'accès au user concerné (page profil)
  def is_admin?
    @user = User.find(params[:id])
    unless current_user == @event.admin
      flash[:danger] = "Vous n'êtes pas autorisé(e) à accéder à cette page"
      redirect_to root_path
    end
  end
  
end
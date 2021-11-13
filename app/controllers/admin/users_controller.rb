class Admin::UsersController < Admin::WelcomeController
  before_action :authenticate_user!
  before_action :is_website_admin?
  before_action :find_user
  
  def show
    @administrated_events = @user.administrated_events  
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), success: "Les informations de l'utilisateur ID:#{@user.id} ont bien été mises à jour !"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, success: "Le compte de l'utilisateur ID:#{@user.id} a été supprimé avec succès."
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description)
  end

  def find_user
    @user = User.find(params[:id])
  end  

  def is_website_admin?
    unless current_user.is_website_admin == true
      redirect_to root_path, danger: "Accès refusé. Vous n'êtes pas administrateur de ce site."
    end
  end
  
end
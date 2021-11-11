class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit]
  before_action :is_permitted_user?, only: [:show, :edit]

  def show
    @user = User.find(params[:id])
    @events = @user.administrated_events
  end

  def edit # TO DO : form pour modifier :first_name, :last_name, :description
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash.now[:success] = "Les informations ont bien été modifiées."
    else
      flash.now[:warning] = @user.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
    flash.now[:success] = "Votre compte a été supprimé avec succès."
  end

  private 
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :description)
  end

end

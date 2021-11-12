class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit]
  before_action :is_permitted_user?, only: [:show, :edit]
  before_action :find_user

  def show
    @events = current_user.administrated_events # ou @user.administrated_events
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash.now[:success] = "Les informations ont bien été modifiées."
    else
      flash.now[:warning] = @user.errors.full_messages
      render :edit
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

  def find_user
    @user = User.find(params[:id])
  end

end

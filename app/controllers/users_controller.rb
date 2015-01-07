class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(safe_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def safe_params
    params.require(:user).permit(:name, :avatar)
  end
end
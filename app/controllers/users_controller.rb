class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params) 
    if @user.save 
      session[:user_id] = @user.id 
      redirect_to home_path
    else 
      render new_user_path
    end 
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if params[:user][:_destroy] == "1"
      destroy
      redirect_to home_path
    else
      @user = User.find(params[:id])
      if @user.update(user_edit_params)
        redirect_to user_path(@user)
      else
        render :edit
      end
    end
  end

  def destroy
  end

  def index
    @users = User.all
  end

  def show
    unless current_user
      redirect_to(:back)
    end
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:username)
  end

  def user_edit_params
    params.require(:user).permit(:first_name,:last_name,:email,:username,:password)
  end
end

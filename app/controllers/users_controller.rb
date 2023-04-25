class UsersController < ApplicationController

  add_flash_types :info, :error, :warning

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/login'
    elsif user.errors
      redirect_to '/signup', notice: user.errors.full_messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)

  end
end

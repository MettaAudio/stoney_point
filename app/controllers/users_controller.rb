class UsersController < ApplicationController
  def index
    @users = User.without(current_user)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      render @user.to_json
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :email,
      :role,
    )
  end
end

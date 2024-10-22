class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = Book.joins(:posts).where(posts: { user_id: @user.id }).distinct
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end

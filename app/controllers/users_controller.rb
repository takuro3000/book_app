class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = Book.joins(:posts).where(posts: { user_id: @user.id }).distinct.page(params[:page]).per(16)
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
    params.require(:user).permit(:name, :self_introduction, :x_url, :github_url, :level ,:icon)
  end
end

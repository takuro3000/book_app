class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :authenticate_user!, only: %i[edit update]
  before_action :authorize_user!, only: %i[edit update]
  def show
    @books = Book.joins(:posts).where(posts: { user_id: @user.id }).distinct.page(params[:page]).per(16)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user!
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), alert: "このプロフィールを編集する権限がありません。"
    end
  end

  def user_params
    params.require(:user).permit(:name, :self_introduction, :x_url, :github_url, :level ,:icon)
  end
end

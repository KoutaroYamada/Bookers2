class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit, :update]

  def index
    @user = User.find(current_user.id)
    @users = User.all
    @booknew = Book.new

  end

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id)
    @booknew = Book.new

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])

      if user.update(user_params)
        flash[:notice] = "You have update your profile successfully."
        redirect_to user_path(user)
      else
        @user = user
        render :edit
        # 直前のページに戻るようにしたいんだけど！！！
      end

  end

  def ensure_correct_user
    if current_user.id !=  params[:id].to_i
     redirect_to user_path(current_user)
    end

  end

private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :followings, :followers]
  before_action :edit_user_check, only: [:edit, :update]

  def show
    if User.find(params[:id]) 
      @user = User.find(params[:id]) 
      @microposts = @user.microposts.order(created_at: :desc)
    else
      flash[:error] = "user not found"
      redirect_to root_path
    end

  end
  
  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcom to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    #@user = User.find(params[:id])
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを編集しました"
      redirect_to user_url
    else
      render 'edit'
    end
  end
  
  def followings
    
    @following = @user.following_users
  end
  
  def followers
    @follower = @user.follower_users
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :area, :profile, :password, :password_confirmation)
  end
  
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def edit_user_check
    redirect_to root_path unless current_user == @user
  end
  
end

class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end
  
  def new
  end
  
  def create
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end   
  end
  
  def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end
  
  def followers
      @user  = User.find(params[:id])
      @users = @user.followers
      render 'show_follower'
  end
  
  def search
    #Viewのformで取得したパラメータをモデルに渡す

    @users = User.search(params[:search])
    @book = Book.new
    @user = current_user

    render 'index'
    # redirect_to users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
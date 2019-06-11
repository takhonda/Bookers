class BooksController < ApplicationController
    
  before_action :ensure_correct_user,only: [:edit,:update,:destroy]
  before_action :authenticate_user!,except: [:home,:about]
  
  def show
    @book = Book.find(params[:id])
    @bookn = Book.new
    @user = current_user
    @books = @user.books
    # @post_comment = @book.post_comments.new
    @post_comment = PostComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @all_ranks = Book.find(Favorite.group(:book_id).order('count(book_id) desc').limit(3).pluck(:book_id))
  end

  def new
    
  end
  
  def about
  
  end
  
  def home
  
  end

  def edit
     @book = Book.find(params[:id])
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have creatad book successfully."
    redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end   
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  
  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @books = Book.search(params[:search])
  end
  
  
  
  private
  def book_params
      params.require(:book).permit(:title, :opinion)
  end
  def ensure_correct_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id && current_user.admin != true
      flash[:notice] = "権限がありません"
      redirect_to books_path
    end
  end
end

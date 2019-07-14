class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit, :update, :destroy]

  def index
    @user = User.find(current_user.id)
    @booknew = Book.new
    @books = Book.all

  end

  def create
    @booknew = Book.new(book_params)
    @booknew.user_id = current_user.id
    if @booknew.save
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@booknew)
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @booknew = Book.new

  end

  def edit
    @book = Book.find(params[:id])

  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(book)
    else
      @book = book
      render :edit
    end


  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path

  end

  def ensure_correct_user
    book = Book.find(params[:id])
    if current_user.id !=  book.user_id
      redirect_to books_path
    end

  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end

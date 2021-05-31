class V1::BooksController < ApplicationController
  before_action :authenticate_v1_user!
  before_action :set_book, only: %i[update destroy]
  def index
    books = Book.all
    render json: books
  end

  def show
    book = Book.find(params[:id])
    render json: book
  end

  def create
    book = current_v1_user.books.new(book_params)

    if book.save
      render json: book
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy!
  end

  private

  def set_book
    @book = current_v1_user.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :description).merge(user_id: current_v1_user.id)
  end
end

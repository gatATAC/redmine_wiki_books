class BooksController < ApplicationController
  before_action :find_project_from_params, only: %i[index new create]
  before_action :find_book, only: %i[show edit update destroy add_book_chapter]
  before_action :authorize

  helper :book_chapters

  def index
    books = Book.where(project: @project).order(:title)
    @grouped = books.group_by { |book| book.title.first.to_s.upcase }
    @book = Book.new(project: @project)
    render layout: false if request.xhr?
  end

  def show
    @book_chapters = @book.book_chapters.to_a
  end

  def new
    @book = Book.new(project: @project)
  end

  def create
    @book = Book.new(book_params)
    @book.project = @project

    if @book.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to book_path(@book)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @book.update(book_params)
      flash[:notice] = l(:notice_successful_update)
      redirect_to book_path(@book)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    project = @book.project
    @book.destroy!
    redirect_to project_books_path(project)
  end

  def add_book_chapter
    @book_chapter = @book.book_chapters.build(book_chapter_params)

    if @book_chapter.save
      flash[:notice] = l(:notice_successful_create)
    else
      flash[:error] = @book_chapter.errors.full_messages.to_sentence
    end

    redirect_to book_path(@book)
  end

  private

  def find_project_from_params
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_book
    @book = Book.find(params[:id])
    @project = @book.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def book_params
    params.require(:book).permit(:title, :description)
  end

  def book_chapter_params
    params.require(:book_chapter).permit(
      :wiki_page_title,
      :chapter_title,
      :order_float,
      :chapter_numbering
    )
  end
end

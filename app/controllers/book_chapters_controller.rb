class BookChaptersController < ApplicationController
  before_action :find_book_chapter
  before_action :authorize

  def show
    @book = @book_chapter.book
    chapters = @book.book_chapters.to_a
    position = chapters.index(@book_chapter)
    @book_chapter_prev = position&.positive? ? chapters[position - 1] : nil
    @book_chapter_next = position ? chapters[position + 1] : nil
  end

  def edit; end

  def update
    if @book_chapter.update(book_chapter_params)
      flash[:notice] = l(:notice_successful_update)
      redirect_to book_path(@book_chapter.book)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    book = @book_chapter.book
    @book_chapter.destroy!
    redirect_to book_path(book)
  end

  private

  def find_book_chapter
    @book_chapter = BookChapter.find(params[:id])
    @project = @book_chapter.project
  rescue ActiveRecord::RecordNotFound
    render_404
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

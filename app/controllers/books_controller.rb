class BooksController < ApplicationController
  unloadable
  default_search_scope :books
  model_object Book
  before_filter :find_project, :only => [:index, :new]
  before_filter :find_model_object, :except => [:index, :new]
  before_filter :find_project_from_association, :except => [:index, :new]
  before_filter :authorize

  helper :book_chapters

  def index
    @sort_by = %w(date title author).include?(params[:sort_by]) ? params[:sort_by] : 'category'
#    books = Book.find_all_by_project_id(@project.id)
     books = Book.where(project_id: @project.id)
     if (books==nil) then
       @grouped={}
     else

    @grouped = books.group_by {|d| d.title.first.upcase}
    if (@grouped==nil) then
        @grouped={}
    end
	end
    @book = Book.new
    @book.project=@project
    render :layout => false if request.xhr?
  end

  def show
    @book_chapters = @book.book_chapters
  end

  def new
    @book = Book.new(user_params)
    @book.project = @project
    if request.post? and @book.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to :action => 'index', :project_id => @project
    end
  end


  def edit
    if request.post? and @book.update_attributes(params[:book])
      flash[:notice] = l(:notice_successful_update)
      redirect_to :action => 'show', :id => @book
    end
  end

  def destroy
    @book.destroy
    redirect_to :controller => 'books', :action => 'index', :project_id => @project
  end

  def add_book_chapter
    book_chapter=@book.book_chapters.build(params[:book_chapter])
    book_chapter.wiki_page_title=params[:book_chapter][:wiki_page_title].to_s
    book_chapter.order_float=params[:book_chapter][:order_float]
    book_chapter.book=@book
    book_chapter.save
    redirect_to :action => 'show', :id => @book
  end

private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Renders a warning flash if obj has unsaved attachments
  def render_book_chapter_warning_if_needed(obj)
    flash[:warning] = "Esto es una prueba"
  end

  def user_params
	params.require(:book).permit(:title, :description)
  end

end

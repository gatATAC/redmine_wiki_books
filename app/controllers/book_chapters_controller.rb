class BookChaptersController < ApplicationController
  unloadable 
  before_filter :find_project
  before_filter :read_authorize, :except => :destroy
  before_filter :delete_authorize, :only => :destroy

  verify :method => :post, :only => :destroy

  def show
    @book=@book_chapter.book
    @book_chapter_number = @book.book_chapters.index(@book_chapter)
    @book_chapter_next = @book.book_chapters[@book_chapter_number+1]
    if (@book_chapter_number>0)
    @book_chapter_prev = @book.book_chapters[@book_chapter_number-1]
    else
      @book_chapter_prev = nil
    end
  end
  
  #def destroy
    # Make sure association callbacks are called
   # @book_chapter.book.book_chapters.delete(@book_chapter)
    #redirect_to :back
  #rescue ::ActionController::RedirectBackError
   # redirect_to :controller => 'projects', :action => 'show', :id => @project
  #end
  
  def destroy
    book=@book_chapter.book
    @book_chapter.destroy
    redirect_to :controller => 'books', :action => 'show', :id => book
  end
  
  
  def edit
    if request.post? and @book_chapter.update_attributes(params[:book_chapter])
      flash[:notice] = l(:notice_successful_update)
      redirect_to :controller => 'books', :action => 'show', :id => @book_chapter.book
    end
  end  
private
  def find_project
    @book_chapter = BookChapter.find(params[:id])
    # Show 404 if the wiki_page in the url is wrong
    raise ActiveRecord::RecordNotFound if params[:wiki_page_title] && params[:wiki_page_title] != @book_chapter.wiki_page_title
    @project = @book_chapter.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def read_authorize
    @book_chapter.visible? ? true : deny_access
  end

  def delete_authorize
    @book_chapter.deletable? ? true : deny_access
  end

end

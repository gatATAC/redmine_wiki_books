module BookChaptersHelper
  # Displays view/delete links to the book_chapters of the given object
  # Options:
  #   :author -- author names are not displayed if set to false
  def link_to_book_chapters(book, options = {})
    if book.book_chapters.any?
      options = {:deletable => book.book_chapters_deletable?}.merge(options)
      render :partial => 'book_chapters/links', :locals => {:book_chapters => book.book_chapters, :options => options}
    end
  end
  
end

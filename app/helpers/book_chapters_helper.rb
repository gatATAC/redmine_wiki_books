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

  # Display a link if user is authorized
  #
  # @param [String] name Anchor text (passed to link_to)
  # @param [Hash] options Hash params. This will checked by authorize_for to see if the user is authorized
  # @param [optional, Hash] html_options Options passed to link_to
  # @param [optional, Hash] parameters_for_method_reference Extra parameters for link_to
  def link_label_to_if_authorized(label, name, rejection_text, options = {}, html_options = nil, *parameters_for_method_reference)
      ret=link_to_if_authorized(name, options, html_options, *parameters_for_method_reference)
      if (!ret.nil?) then
        ret=label+" "+ret
      else
        ret=rejection_text
      end
      ret
  end

end

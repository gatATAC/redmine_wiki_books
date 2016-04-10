class BookChapter < ActiveRecord::Base
  unloadable # <= That's the ticket!
  
  self.table_name = "wiki_book_chapters"

  belongs_to :book

  validates_presence_of :book, :wiki_page_title, :chapter_title
  validates_length_of :wiki_page_title, :maximum => 255
  validates_length_of :chapter_title, :maximum => 255

  acts_as_event :title => :wiki_page_title,
                :url => Proc.new {|o| {:controller => 'book_chapters', :action => 'show', :id => o.id, :wiki_page_title => o.wiki_page_title}}

  acts_as_activity_provider :type => 'books',
                            :permission => :view_books,
			     :scope => {:select => "#{BookChapter.table_name}.*",
                                              :joins => "LEFT JOIN #{Book.table_name} ON #{Book.table_name}.id = #{BookChapter.table_name}.book_id " +
                                                        "LEFT JOIN #{Project.table_name} ON #{Book.table_name}.project_id = #{Project.table_name}.id"}

  def project
    book.project
  end

  def visible?(user=User.current)
    book.book_chapters_visible?(user)
  end

  def deletable?(user=User.current)
    book.book_chapters_deletable?(user)
  end

  def wiki_page
    if project.wiki && !wiki_page_title.blank?
      @wiki_page ||= project.wiki.find_page(wiki_page_title)
    end
    @wiki_page
  end
end

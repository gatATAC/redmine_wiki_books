require File.expand_path("../../lib/redmine_wiki_books/redmine_acts", __dir__)
RedmineWikiBooks::RedmineActs.install!

class BookChapter < ApplicationRecord
  self.table_name = 'wiki_book_chapters'

  belongs_to :book, inverse_of: :book_chapters

  validates :book, :wiki_page_title, :chapter_title, presence: true
  validates :wiki_page_title, :chapter_title, length: { maximum: 255 }

  acts_as_event title: :wiki_page_title,
                url: proc { |chapter|
                  {
                    controller: 'book_chapters',
                    action: 'show',
                    id: chapter.id
                  }
                }

  acts_as_activity_provider type: :books,
                            permission: :view_books,
                            scope: -> { joins(book: :project) }

  def project
    book.project
  end

  def visible?(user = User.current)
    book.book_chapters_visible?(user)
  end

  def deletable?(user = User.current)
    book.book_chapters_deletable?(user)
  end

  def wiki_page
    return unless project.wiki && wiki_page_title.present?

    @wiki_page ||= project.wiki.find_page(wiki_page_title)
  end
end

require File.expand_path("../../lib/redmine_wiki_books/redmine_acts", __dir__)
RedmineWikiBooks::RedmineActs.install!

class Book < ApplicationRecord
  self.table_name = 'wiki_books'

  belongs_to :project
  has_many :book_chapters,
           -> { order(:order_float, :id) },
           dependent: :destroy,
           inverse_of: :book

  acts_as_attachable delete_permission: :manage_books

  acts_as_searchable columns: ["#{table_name}.title", "#{table_name}.description"],
                     preload: :project
  acts_as_event title: proc { |book| "#{l(:label_book)}: #{book.title}" },
                url: proc { |book| { controller: 'books', action: 'show', id: book.id } }
  acts_as_activity_provider scope: -> { includes(:project) }

  validates :project, :title, presence: true
  validates :title, length: { maximum: 60 }

  scope :visible, lambda { |user = User.current, options = {}|
    joins(:project).where(Project.allowed_to_condition(user, :view_books, options))
  }

  def visible?(user = User.current)
    user.present? && user.allowed_to?(:view_books, project)
  end

  def book_chapters_deletable?(user = User.current)
    visible?(user) && user.allowed_to?(:manage_books, project)
  end

  def book_chapters_visible?(user = User.current)
    user.present? && user.allowed_to?(:view_book_chapters, project)
  end

  def updated_on
    [self[:updated_on], book_chapters.maximum(:updated_on)].compact.max
  end
end

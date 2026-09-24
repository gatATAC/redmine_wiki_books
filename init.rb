require File.expand_path("lib/redmine_wiki_books/redmine_acts", __dir__)
RedmineWikiBooks::RedmineActs.install!

Redmine::Plugin.register :redmine_wiki_books do
  name 'Redmine Wiki Books plugin'
  author 'Txinto Vaz'
  description 'Arrange project wiki pages as ordered books with chapter navigation.'
  version '0.1.1'
  url 'https://github.com/gatATAC/redmine_wiki_books'
  author_url 'https://github.com/txinto'

  requires_redmine version_or_higher: '7.0.1'

  project_module :books do
    permission :view_books, books: %i[index show]
    permission :manage_books, {
      books: %i[new create edit update destroy add_book_chapter],
      book_chapters: %i[edit update destroy]
    }
    permission :view_book_chapters, book_chapters: %i[show]
  end

  menu :project_menu, :books,
       { controller: 'books', action: 'index' },
       caption: :label_book_plural,
       after: :activity,
       param: :project_id
end

# Redmine memoizes this list and does not invalidate it when a plugin is
# registered after the first lookup.
available_modules = Redmine::AccessControl.available_project_modules
available_modules << :books unless available_modules.include?(:books)

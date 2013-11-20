class RenameTables < ActiveRecord::Migration
  def change
    rename_table :books, :wiki_books
    rename_table :book_chapters, :wiki_book_chapters
  end
end

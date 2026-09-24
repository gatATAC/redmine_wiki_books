class RenameTables < ActiveRecord::Migration[8.0]
  def change
    rename_table :books, :wiki_books
    rename_table :book_chapters, :wiki_book_chapters
  end
end

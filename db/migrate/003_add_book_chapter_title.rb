class AddBookChapterTitle < ActiveRecord::Migration
  def change
    add_column :book_chapters, :chapter_title, :string
  end
end

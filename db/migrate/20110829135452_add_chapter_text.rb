class AddChapterText < ActiveRecord::Migration
  def self.up
    add_column :book_chapters, :chapter_numbering, :string
  end

  def self.down
    remove_column :book_chapters, :chapter_numbering
  end
end

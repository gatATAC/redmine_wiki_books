class AddChapterTitles < ActiveRecord::Migration
  def self.up
    add_column :book_chapters, :chapter_title, :string
  end

  def self.down
    remove_column :book_chapters, :chapter_title
  end
end

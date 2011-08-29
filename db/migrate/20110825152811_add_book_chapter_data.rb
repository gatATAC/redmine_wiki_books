class AddBookChapterData < ActiveRecord::Migration
  def self.up
      add_column :book_chapters, :created_on, :timestamp
      add_column :book_chapters, :updated_on, :timestamp
  end

  def self.down
    remove_column :book_chapters, :created_on
    remove_column :book_chapters, :updated_on
  end
end

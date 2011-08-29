class ChangeChapterOrder < ActiveRecord::Migration
  def self.up
    add_column :book_chapters, :order_float, :float
    remove_column :book_chapters, :order
  end

  def self.down
    add_column :book_chapters, :order, :integer
    remove_column :book_chapters, :order_float
  end
end

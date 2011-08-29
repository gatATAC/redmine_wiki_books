class AddBookChapterWikiPaths < ActiveRecord::Migration
  def self.up
    remove_column :book_chapters, :wiki_page_id
    add_column :book_chapters, :link_path, :string
  end

  def self.down
    add_column :book_chapters, :wiki_page_id, :integer
    remove_column :book_chapters, :link_path
  end
end

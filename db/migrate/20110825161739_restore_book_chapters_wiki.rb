class RestoreBookChaptersWiki < ActiveRecord::Migration
    add_column :book_chapters, :wiki_page_id,:integer
    remove_column :book_chapters, :link_path
  end

  def self.down
    remove_column :book_chapters, :wiki_page_id
    add_column :book_chapters, :link_path, :string
end

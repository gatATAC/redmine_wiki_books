class CreateBookChapters < ActiveRecord::Migration
  def self.up
    create_table :book_chapters do |t|

      t.column :book_id, :integer

      t.column :wiki_page_id, :integer

      t.column :parent_id, :integer

      t.column :order, :integer

    end
  end

  def self.down
    drop_table :book_chapters
  end
end

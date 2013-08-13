class CreateBookChapters < ActiveRecord::Migration
  def change
    create_table :book_chapters do |t|
      t.integer :book_id
      t.integer :parent_id
      t.string :wiki_page_title
      t.float :order_float
      t.string :chapter_numbering
      t.string :chapter_title
      t.timestamp :created_on
      t.timestamp :updated_on
    end
  end
end

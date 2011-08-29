class AddBookData < ActiveRecord::Migration
  def self.up
      add_column :books, :description, :text
      add_column :books, :created_on, :timestamp
      add_column :books, :updated_on, :timestamp
  end

  def self.down
    remove_column :books, :description
    remove_column :books, :created_on
    remove_column :books, :updated_on
  end
end

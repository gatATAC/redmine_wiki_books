class AddBookProjects < ActiveRecord::Migration
  def self.up
      add_column :books, :project_id, :integer
  end

  def self.down
    remove_column :books, :project_id
  end
end

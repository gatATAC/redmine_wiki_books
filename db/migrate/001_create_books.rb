class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :project_id
      t.text :description
      t.timestamp :created_on
      t.timestamp :updated_on
    end
  end
end

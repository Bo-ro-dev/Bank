class AddTitleToOperations < ActiveRecord::Migration[6.0]
  def change
    add_column :operations, :title, :string
  end
end

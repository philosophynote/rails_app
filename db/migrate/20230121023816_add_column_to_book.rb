class AddColumnToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :created_at, :datetime, null: false, default: -> { 'NOW()' }
    add_column :books, :updated_at, :datetime, null: false, default: -> { 'NOW()' }
  end
end

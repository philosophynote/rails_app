class ChangeColumnToAuthorities < ActiveRecord::Migration[6.1]
  def change
    change_column :authorities, :authority, :integer, null: false, default: 0
  end
end

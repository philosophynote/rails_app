class CreateAuthorities < ActiveRecord::Migration[6.1]
  def change
    create_table :authorities do |t|
      t.string :authority
      t.references :rule, null: false, foreign_key: true
      t.timestamps
    end
  end
end

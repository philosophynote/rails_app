class CreateAuthorityServiceRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :authority_service_relations do |t|
      t.belongs_to  :authority
      t.belongs_to  :service
      t.timestamps
    end
  end
end

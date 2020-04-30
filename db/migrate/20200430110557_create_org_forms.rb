class CreateOrgForms < ActiveRecord::Migration[6.0]
  def change
    create_table :org_forms do |t|
      t.string :name
      t.string :label

      t.timestamps
    end
  end
end

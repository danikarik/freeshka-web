class AddProfileFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, after: :email
    add_column :users, :description, :text, after: :name
    add_reference :users, :org_form, null: true, foreign_key: true, after: :locked_at
  end
end

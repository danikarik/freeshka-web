class AddUniqueIndexToPhones < ActiveRecord::Migration[6.0]
  def change
    add_index :phones, [:number, :user_id], unique: true
  end
end

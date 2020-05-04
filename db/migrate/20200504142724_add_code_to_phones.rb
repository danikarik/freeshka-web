class AddCodeToPhones < ActiveRecord::Migration[6.0]
  def change
    add_column :phones, :code, :string, after: :is_verified
  end
end

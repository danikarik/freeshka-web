class CreateKarmas < ActiveRecord::Migration[6.0]
  def change
    create_table :karmas do |t|
      t.references :user, null: false, foreign_key: { to_table: 'users' }
      t.references :reviewer, null: false, foreign_key: { to_table: 'users' }
      t.integer :point
      t.references :message, null: true, foreign_key: true
      t.references :post, null: true, foreign_key: true

      t.timestamps
    end
  end
end

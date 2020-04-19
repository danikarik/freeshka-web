class AddPostRefsToRooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :post, null: false, foreign_key: true, after: :name
  end
end

class CreatePostsCategoriesJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :posts, :categories
  end
end

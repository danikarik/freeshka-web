class CreatePostsCitiesJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :posts, :cities
  end
end

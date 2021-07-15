class AddToLikes < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :likes, :users, column: :user_like_id
    add_foreign_key :likes, :posts, column: :post__like_id
  end
end 

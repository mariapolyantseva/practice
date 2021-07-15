class AddToFollows < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :follows, :users, column: :follower_id
    add_foreign_key :follows, :users, column: :following_id
  end
end

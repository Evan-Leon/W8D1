class ChangePosts < ActiveRecord::Migration[5.2]
  def change

    remove_column :posts, :sub_id 
    add_column :posts, :sub, :string
  end
end

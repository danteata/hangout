class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :user_id
      t.integer :poster_id
      t.string :content

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :created_at
  end

  def self.down
    drop_table :posts
  end
end

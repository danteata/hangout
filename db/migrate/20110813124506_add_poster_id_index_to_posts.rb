class AddPosterIdIndexToPosts < ActiveRecord::Migration
  def self.up
    add_index :posts, :poster_id
    add_index :posts, [:user_id, :poster_id]
  end

  def self.down
  end
end

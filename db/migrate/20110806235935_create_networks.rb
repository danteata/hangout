class CreateNetworks < ActiveRecord::Migration
  def self.up
    create_table :networks do |t|
      t.integer :user_id
      t.string :facebook
      t.string :twitter
      t.string :linkedin
      t.string :youtube

      t.timestamps
    end
  end

  def self.down
    drop_table :networks
  end
end

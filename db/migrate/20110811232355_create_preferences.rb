class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.integer :user_id
      t.string :profile_view, :default => "all"

      t.timestamps
    end
  end

  def self.down
    drop_table :preferences
  end
end

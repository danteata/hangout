class CreateSpecs < ActiveRecord::Migration
  def self.up
    create_table :specs do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :birthday
      t.string :occupation
      t.string :city

      t.timestamps
    end
  end

  def self.down
    drop_table :specs
  end
end

class CreateRovers < ActiveRecord::Migration
  def self.up
    create_table :rovers do |t|
      t.integer :y_position
      t.integer :x_position
      t.string :direction
      t.string :instruction
      t.integer :step

      t.timestamps
    end
  end

  def self.down
    drop_table :rovers
  end
end

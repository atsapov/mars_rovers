class CreateRovers < ActiveRecord::Migration
  def self.up
    create_table :rovers do |t|
      t.integer :h_plato
      t.integer :w_plato
      t.integer :x_position
      t.integer :y_position
      t.string :direction
      t.string :instruction
      t.string :plato
      t.integer :step

      t.timestamps
    end
  end

  def self.down
    drop_table :rovers
  end
end

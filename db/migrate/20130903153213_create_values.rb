class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.integer :decibel
      t.integer :sensor_id

      t.timestamps
    end
  end
end

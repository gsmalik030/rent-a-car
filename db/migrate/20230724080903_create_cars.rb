class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.string :color
      t.string :model
      t.float :rent
      t.float :rating, default: 0
      t.text :description

      t.timestamps
    end
  end
end

class CreateMaterials < ActiveRecord::Migration[5.1]
  def change
    create_table :materials do |t|
      t.references :order, foreign_key: true
      t.string :title
      t.integer :price
      t.integer :storable_id
      t.string :storable_type

      t.timestamps
    end
    add_index :materials, :storable_id
    add_index :materials, :storable_type
  end
end

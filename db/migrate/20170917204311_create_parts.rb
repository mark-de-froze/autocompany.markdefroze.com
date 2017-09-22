class CreateParts < ActiveRecord::Migration[5.1]
  def change
    create_table :parts do |t|
      t.string :title
      t.integer :price
      t.string :code
      t.integer :unit
      t.references :storable, polymorphic: true

      t.timestamps
    end
  end
end

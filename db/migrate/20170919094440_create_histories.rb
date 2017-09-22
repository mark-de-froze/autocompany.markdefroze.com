class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.string :title
      t.integer :price
      t.string :code
      t.integer :quantity
      t.integer :status
      t.references :trackable, polymorphic: true

      t.timestamps
    end
  end
end

class AddQuantityToMaterials < ActiveRecord::Migration[5.1]
  def change
    add_column :materials, :quantity, :integer, default: 1
  end
end

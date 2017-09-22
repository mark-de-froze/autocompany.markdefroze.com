class AddQuantityToOils < ActiveRecord::Migration[5.1]
  def change
    add_column :oils, :quantity, :integer
  end
end

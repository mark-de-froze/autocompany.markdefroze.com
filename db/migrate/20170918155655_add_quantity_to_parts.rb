class AddQuantityToParts < ActiveRecord::Migration[5.1]
  def change
    add_column :parts, :quantity, :integer
  end
end

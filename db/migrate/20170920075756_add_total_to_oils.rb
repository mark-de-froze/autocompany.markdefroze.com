class AddTotalToOils < ActiveRecord::Migration[5.1]
  def change
    add_column :oils, :total, :integer
  end
end

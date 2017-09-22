class AddMileageToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :mileage, :integer
  end
end

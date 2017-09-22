class AddFieldsToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :engine_number, :string
    add_column :cars, :engine_type, :integer
    add_column :cars, :engine_capacity, :integer
    add_column :cars, :state_number, :string
    add_column :cars, :mileage, :integer
  end
end

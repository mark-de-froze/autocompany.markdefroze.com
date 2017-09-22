class AddWorkerRegToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :worker, foreign_key: true
  end
end

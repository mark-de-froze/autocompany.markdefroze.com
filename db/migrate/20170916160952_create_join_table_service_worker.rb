class CreateJoinTableServiceWorker < ActiveRecord::Migration[5.1]
  def change
    create_join_table :services, :workers do |t|
      t.index [:service_id, :worker_id]
      t.index [:worker_id, :service_id]
    end
  end
end

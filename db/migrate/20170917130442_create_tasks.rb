class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :order, foreign_key: true
      t.references :service, foreign_key: true
      t.references :job, foreign_key: true
      t.references :worker, foreign_key: true
      t.integer :price
      t.datetime :finished_at

      t.timestamps
    end
  end
end

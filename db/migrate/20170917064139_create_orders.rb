class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :title
      t.text :content
      t.references :car, foreign_key: true
      t.references :client, foreign_key: true
      t.datetime :finished_at

      t.timestamps
    end
  end
end

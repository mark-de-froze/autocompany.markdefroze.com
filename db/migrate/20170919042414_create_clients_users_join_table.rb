class CreateClientsUsersJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :clients, :users do |t|
      t.index :client_id
      t.index :user_id
    end
  end
end

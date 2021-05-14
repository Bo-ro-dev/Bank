class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :name
      t.integer :requester_id
      t.integer :target_id
      t.integer :amount

      t.timestamps
    end
  end
end

class CreateOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :operations do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :amount
      t.integer :balance_after_operation

      t.timestamps
    end
  end
end

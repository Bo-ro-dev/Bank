class AddAccountsBalanceToOperations < ActiveRecord::Migration[6.0]
  def change
    add_column :operations, :sender_balance_after_operation, :integer
    add_column :operations, :receiver_balance_after_operation, :integer
  end
end

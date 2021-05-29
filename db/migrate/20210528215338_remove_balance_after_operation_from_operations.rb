class RemoveBalanceAfterOperationFromOperations < ActiveRecord::Migration[6.0]
  def change
    remove_column :operations, :balance_after_operation, :integer
  end
end

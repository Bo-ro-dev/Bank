class AddAccountNumberToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :account_number, :integer
  end
end

# == Schema Information
#
# Table name: operations
#
#  id                      :bigint           not null, primary key
#  sender_id               :integer
#  receiver_id             :integer
#  amount                  :integer
#  balance_after_operation :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  title                   :string
#
class Operation < ApplicationRecord
  #validates :amount, :inclusion => 1..Account.find_by(user_id: @current_user.id).balance

  belongs_to :sender, class_name: 'Account'
  belongs_to :receiver, class_name: 'Account'

  #def self.search(search)
  #  if search
    #  where('account_information(operation.sender_id) ILIKE ?', "%#{search}%").or(
    #    where('account_information(operation.receiver_id) ILIKE ?', "%#{search}%")
    #  )
  #  else
  #    all
  #  end
  #end
end

# == Schema Information
#
# Table name: operations
#
#  id                               :bigint           not null, primary key
#  sender_id                        :integer
#  receiver_id                      :integer
#  amount                           :integer
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  title                            :string
#  sender_balance_after_operation   :integer
#  receiver_balance_after_operation :integer
#
class Operation < ApplicationRecord
  belongs_to :sender, class_name: 'Account'
  belongs_to :receiver, class_name: 'Account'
end

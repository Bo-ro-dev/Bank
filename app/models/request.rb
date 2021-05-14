# == Schema Information
#
# Table name: requests
#
#  id           :bigint           not null, primary key
#  name         :string
#  requester_id :integer
#  target_id    :integer
#  amount       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Request < ApplicationRecord
  belongs_to :requester, class_name: 'Account'
  belongs_to :target, class_name: 'Account'
end

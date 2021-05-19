# == Schema Information
#
# Table name: accounts
#
#  id             :bigint           not null, primary key
#  balance        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#  account_number :integer
#  first_name     :string
#  last_name      :string
#
class Account < ApplicationRecord
  validates :balance, :user_id, :account_number, :first_name, :last_name, presence: true
  validates :account_number, :user_id, uniqueness: true
  validates :account_number, length: { is: 9 }
  before_save :capitalize_name
  belongs_to :user
  has_many :incoming_operations, class_name: 'Operation', foreign_key: :receiver_id
  has_many :outcoming_operations, class_name: 'Operation', foreign_key: :sender_id
  has_many :incoming_requests, class_name: 'Request', foreign_key: :target_id
  has_many :outcoming_requests, class_name: 'Request', foreign_key: :requester_id

  def operations
    Operation.where(sender_id: id).or(
      Operation.where(receiver_id: id)
    )
  end

  def requests
    Request.where(requester_id: id).or(
      Request.where(target_id: id)
    )
  end

  def capitalize_name
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  google_secret          :string
#
class User < ApplicationRecord
  acts_as_google_authenticated
  after_create :set_google_secret
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :account
end

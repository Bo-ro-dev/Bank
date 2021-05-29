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
require 'rails_helper'

RSpec.describe Account, type: :model do

end

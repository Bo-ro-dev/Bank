module AccountsHelper

  def account_information(id_params)
    @user_information = Account.find_by(id: id_params)
    @user_information.account_number
  end

end

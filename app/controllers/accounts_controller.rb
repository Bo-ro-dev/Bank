class AccountsController < ApplicationController
    skip_before_action :require_created_account, only: [:new, :create]


  def show
    @account = current_user.account
    @latest_operations = current_user.account.operations.includes(:sender, :receiver).order(created_at: :desc).first(10)
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    @account.user = current_user
    @account.balance = 0
    if @account.save
      redirect_to @account
      flash.notice = "Utworzono konto"
    else
      render :action => "new", notice:
      flash.alert = "Coś poszło nie tak, spróbuj ponownie"
    end
  end

  private

  def account_params
    params.require(:account).permit(:account_number, :first_name, :last_name)
  end
end

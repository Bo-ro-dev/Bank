class AccountsController < ApplicationController
    skip_before_action :require_created_account, only: [:new, :create]


  def show
    @account = current_user.account
    @latest_operations = current_user.account.operations.includes(:sender, :receiver).order(created_at: :desc).first(10)
  end

  def new

    @account = Account.new
    @qr = current_user.google_qr_uri

  end

  def create
    @account = Account.new(account_params)
    @account.user = current_user

    @account.balance = 0

    if current_user.google_authentic?(google_token)
      if @account.save
        redirect_to @account
        flash.notice = "Utworzono konto"
      else
        flash.alert = "Coś poszło nie tak, spróbuj ponownie"
        @qr = current_user.google_qr_uri
        render action: "new"
      end
    else
      flash[:notice] = "Podano nieprawidłowy kod"
      @qr = current_user.google_qr_uri
      render action: "new"
    end
  end

  private

  def account_params
    params.require(:account).permit(:account_number, :first_name, :last_name)
  end

  def google_token
    params[:account][:google_token].to_s
  end
end

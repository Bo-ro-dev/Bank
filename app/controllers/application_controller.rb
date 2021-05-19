class ApplicationController < ActionController::Base


  before_action :authenticate_user!

  before_action :require_created_account

  private

  def require_created_account
    return unless current_user
    return if current_user.account

    redirect_to new_account_path
  end

end

class OperationsController < ApplicationController

  def create
    if current_user.google_authentic?(params[:google_token])
      sender = current_user.account
      receiver = Account.find_by!(account_number: params[:receiver_id])
      params[:title].empty? ? title = "Przelew środków" : title = params[:title]
      ActiveRecord::Base.transaction do
        OperationService.new(sender, receiver, params[:amount].to_i, title).transfer
      end
      redirect_to :root, notice: "Wysłano środki"
    else
      flash[:notice] = "Nieprawidłowy token"
    end
  rescue OperationService::NotEnoughFundsError
    redirect_to :root, notice: "Niewystarczająca ilość środków na koncie"
  end


  def index
    search = params[:search]
    @operations = current_user.account.operations.includes(:sender, :receiver).order(created_at: :desc)
  end

   def new
    @account = current_user.account
    @receiver_number = params[:receiver]
    @amount = params[:amount]
  end

  private

  def filter_by_dates(operations)
    from = Time.parse(params[:search_date_from]) rescue Time.at(0)
    to = Time.parse(params[:search_date_to]).end_of_day rescue nil
    range = from..to
    operations.where(created_at: range)
  end
end

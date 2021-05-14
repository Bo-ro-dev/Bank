class OperationsController < ApplicationController

  def create
    sender = current_user.account
    receiver = Account.find_by!(account_number: params[:receiver_id])
    if params[:title].empty?
      title = "Przelew środków"
    else
      title = params[:title]
    end
    ActiveRecord::Base.transaction do
      OperationService.new(sender, receiver, params[:amount].to_i, title).transfer
    end


    redirect_to root_path, notice: "Wysłano środki"
    rescue OperationService::NotEnoughFundsError
      redirect_to :root, notice: "Niewystarczająca ilość środków na koncie"
  end


  def index

    search = params[:search]
    #time_range = Time.parse(params[:search_date_from])..(Time.parse(params[:search_date_to]).end_of_day)
    # @operations = current_user.account.operations
    #                                     .joins("JOIN accounts AS sender ON sender.id = operations.sender_id
    #                                             JOIN accounts AS receiver ON receiver.id = operations.receiver_id")
    #                                     where('sender.account_number ILIKE ?', "%#{search}%").or(
    #                                       where('receiver.account_number ILIKE ?', "%#{search}%")
    #                                     )
    @operations = current_user.account.operations.includes(:sender, :receiver)
    #@operations = filter_by_dates(@operations)
  end
#search(params[:search]).order('created_at ASC')
    #joins(INNER JOIN accounts ON operations.account_id = accounts.id )

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

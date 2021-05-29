class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests = current_user.account.requests.includes(:target, :requester)
  end

  def new
    @request = Request.new
  end

  def create
    if current_user.google_authentic?(params[:google_token].to_s)
      RequestService.create_request(
        requester: current_user.account,
        target: Account.find_by!(account_number: params[:target_id].to_i),
        amount: request_params[:amount],
        name: request_params[:name]
      )
      redirect_to root_path, notice: "Wysłano prośbę o przelew"
    else
      flash[:notice] = "Nieprawidłowy token"
    end
  end

  def destroy
    request = current_user.account.requests.find(params[:id])
    RequestService.cancel_request(request)
    flash[:notice] = "Cofnięto prośbę o przelew"
    redirect_back fallback_location: { action: "show" }
  end

  def accept
    request = current_user.account.incoming_requests.find(params[:id])
    RequestService.accept_request(request)
    redirect_to root_path, notice: "Wysłano środki"
  rescue OperationService::NotEnoughFundsError
    redirect_to :root, notice: "Niewystarczająca ilość środków na koncie"
  end

  def reject
    request = current_user.account.incoming_requests.find(params[:id])
    RequestService.reject_request(request)
    flash[:notice] = "Odrzucono prośbę o przelew"
    redirect_back fallback_location: { action: "show" }
  end

  private

  def request_params
    params
  end
end

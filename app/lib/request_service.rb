class RequestService
  def self.create_request(requester:, target:, amount:, name:)
    Request.create!(requester: requester, target: target, name: name, amount: amount)
  end

  def self.cancel_request(request)
    request.destroy!
  end

  def self.reject_request(request)
    request.destroy!
  end

  def self.accept_request(request)
    OperationService.new(request.target, request.requester, request.amount, request.name).transfer
    request.destroy!
  end
end

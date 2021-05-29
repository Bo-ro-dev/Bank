class OperationService
  class NotEnoughFundsError < StandardError
  end

  def initialize(sender, receiver, amount, title)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @title = title
  end

  def transfer
    raise NotEnoughFundsError if @sender.balance < @amount

    @sender.update!(balance: @sender.balance - @amount)
    @receiver.update!(balance: @receiver.balance + @amount)
    Operation.create!(
      sender:   @sender,
      receiver: @receiver,
      amount:   @amount,
      title:    @title,
      sender_balance_after_operation: @sender.balance,
      receiver_balance_after_operation: @receiver.balance
    )
  end
end

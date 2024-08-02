module PaymentsHelper
  def payment_status_class(status)
    case status
    when "pending"
      "text-bg-warning"
    when "paid"
      "text-bg-success"
    when "overdue"
      "text-bg-danger"
    else
      "text-bg-secondary"
    end
  end
end

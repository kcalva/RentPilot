class OverduePaymentNotificationJob < ApplicationJob
  queue_as :default

  def perform(payment_id)
    payment = Payment.find(payment_id)

    # Only send email if the payment is still overdue
    if payment.status == "overdue"
      PaymentMailer.overdue_payment_email(payment).deliver_now
    end
  end
end

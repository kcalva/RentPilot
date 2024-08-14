class PaymentMailer < ApplicationMailer
  default from: "no-reply@yourapp.com"

  def overdue_payment_email(payment)
    @payment = payment
    @tenant = payment.tenant
    mail(to: @tenant.email, subject: "Your Payment is Overdue")
  end
end

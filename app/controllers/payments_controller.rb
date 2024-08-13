class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[edit update destroy]
  before_action :set_tenant_and_unit, only: %i[new create]

  # GET /payments or /payments.json
  def index
    if params[:user_id]
      @tenant = User.find(params[:user_id])
      @payments = @tenant.payments
    else
      @payments = Payment.all.includes(:tenant, :unit)
    end
    @overdue_payments = @payments.where(status: "overdue").order(due_date: :desc)
    @pending_payments = @payments.where(status: "pending").order(due_date: :desc)
    @paid_payments = @payments.where(status: "paid").order(due_date: :desc)
  end

  # GET /payments/new
  def new
    @payment = @tenant.payments.new
  end

  # GET /payments/1/edit
  def edit
    @tenant = @payment.tenant
  end

  # POST /payments
  def create
    @payment = @tenant.payments.new(payment_params)
    @payment.unit = @unit

    if @payment.save
      redirect_to user_payments_path(@payment.tenant), notice: "Payment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payments/1
  def update
    if @payment.update(payment_params)
      redirect_to user_payments_path(@payment.tenant), notice: "Payment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @payment.destroy!
    redirect_to user_payments_path(@payment.tenant), notice: "Payment was successfully destroyed."
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def set_tenant_and_unit
    @tenant = User.find(params[:user_id])
    @unit = @tenant.units.first
  end

  def payment_params
    params.require(:payment).permit(:amount, :due_date, :paid_at, :status)
  end
end

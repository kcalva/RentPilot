class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[edit update destroy]
  before_action :set_tenant_and_unit, only: %i[new create]

  # GET /payments or /payments.json
  def index
    if params[:user_id]
      @tenant = User.find(params[:user_id])
      @payments = @tenant.payments
      @overdue_payments = @payments.where(status: "overdue").order(due_date: :desc)
      @pending_payments = @payments.where(status: "pending").order(due_date: :desc)
      @paid_payments = @payments.where(status: "paid").order(due_date: :desc)
    else
      @payments = Payment.all
    end
  end

  # GET /payments/new
  def new
    @payment = @tenant.payments.new
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find(params[:id])
    @tenant = @payment.tenant
  end

  # POST /payments
  def create
    @payment = @tenant.payments.new(payment_params)
    @payment.unit = @unit

    respond_to do |format|
      if @payment.save
        format.html { redirect_to user_payments_path(@payment.tenant), notice: "Payment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to user_payments_path(@payment.tenant), notice: "Payment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  def destroy
    @payment.destroy!
    respond_to do |format|
      format.html { redirect_to user_payments_path(@payment.tenant), notice: "Payment was successfully destroyed." }
    end
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

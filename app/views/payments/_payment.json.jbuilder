json.extract! payment, :id, :unit_id, :tenant_id, :amount, :due_date, :paid_at, :status, :created_at, :updated_at
json.url payment_url(payment, format: :json)

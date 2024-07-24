json.extract! lease, :id, :unit_id, :tenant_id, :start_date, :end_date, :rent_amount, :created_at, :updated_at
json.url lease_url(lease, format: :json)

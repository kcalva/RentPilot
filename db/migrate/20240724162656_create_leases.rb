class CreateLeases < ActiveRecord::Migration[7.1]
  def change
    create_table :leases do |t|
      t.integer :unit_id
      t.integer :tenant_id
      t.date :start_date
      t.date :end_date
      t.decimal :rent_amount

      t.timestamps
    end
  end
end

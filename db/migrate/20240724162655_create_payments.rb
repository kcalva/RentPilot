class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.integer :unit_id
      t.integer :tenant_id
      t.decimal :amount
      t.date :due_date
      t.datetime :paid_at
      t.string :status

      t.timestamps
    end
  end
end

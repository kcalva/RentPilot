class CreateUnits < ActiveRecord::Migration[7.1]
  def change
    create_table :units do |t|
      t.integer :property_id
      t.string :unit_number
      t.integer :tenant_id

      t.timestamps
    end
  end
end

class AddSecurityDepositToLeases < ActiveRecord::Migration[7.1]
  def change
    add_column :leases, :security_deposit, :decimal
  end
end

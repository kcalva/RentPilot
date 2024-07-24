# == Schema Information
#
# Table name: leases
#
#  id          :integer          not null, primary key
#  end_date    :date
#  rent_amount :decimal(, )
#  start_date  :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  tenant_id   :integer
#  unit_id     :integer
#
class Lease < ApplicationRecord
end

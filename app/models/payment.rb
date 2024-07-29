# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  amount     :decimal(, )
#  due_date   :date
#  paid_at    :datetime
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tenant_id  :integer
#  unit_id    :integer
#
class Payment < ApplicationRecord
end

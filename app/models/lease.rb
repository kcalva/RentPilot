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
  validates :rent_amount, presence: true, numericality: { greater_than: 0 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :tenant_id, presence: true
  validates :unit_id, presence: true

  belongs_to :tenant, class_name: "User"
  belongs_to :unit
end

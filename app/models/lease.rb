# == Schema Information
#
# Table name: leases
#
#  id               :bigint           not null, primary key
#  end_date         :date
#  rent_amount      :decimal(, )
#  security_deposit :decimal(, )
#  start_date       :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tenant_id        :integer
#  unit_id          :integer
#
class Lease < ApplicationRecord
  validates :rent_amount, presence: true, numericality: { greater_than: 0 }
  validates :security_deposit, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :start_date, :end_date, :tenant_id, :unit_id, presence: true

  belongs_to :tenant, class_name: "User"
  belongs_to :unit

  has_one_attached :pdf
end

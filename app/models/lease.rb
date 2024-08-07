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
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :tenant_id, presence: true
  validates :unit_id, presence: true
  validates :security_deposit, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  belongs_to :tenant, class_name: "User"
  belongs_to :unit

  has_one_attached :pdf
end

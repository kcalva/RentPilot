# == Schema Information
#
# Table name: payments
#
#  id         :bigint           not null, primary key
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
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending paid overdue] }
  validates :due_date, presence: true
  validates :tenant_id, presence: true
  validates :unit_id, presence: true

  belongs_to :tenant, class_name: "User"
  belongs_to :unit

  has_one :property, through: :unit, source: :property

  after_save :check_overdue_status

  private

  def check_overdue_status
    if saved_change_to_status? && status == "overdue"
      OverduePaymentNotificationJob.perform_later(id)
    end
  end
end

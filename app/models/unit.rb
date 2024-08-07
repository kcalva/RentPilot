# == Schema Information
#
# Table name: units
#
#  id          :bigint           not null, primary key
#  unit_number :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  property_id :integer
#  tenant_id   :integer
#
class Unit < ApplicationRecord
  validates :unit_number, presence: true
  validates :property_id, presence: true
  validates :tenant_id, presence: true

  belongs_to :tenant, class_name: "User"
  belongs_to :property
  has_many :payments, dependent: :destroy
  has_many :leases, dependent: :destroy
end

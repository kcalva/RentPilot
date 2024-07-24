# == Schema Information
#
# Table name: properties
#
#  id          :integer          not null, primary key
#  address     :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  landlord_id :integer
#
class Property < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :landlord_id, presence: true

  belongs_to :landlord, class_name: "User"
  has_many :units, dependent: :destroy

  has_many :tenants, through: :units, source: :tenant
  has_many :payments, through: :units, source: :payments
end

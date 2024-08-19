# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_default_role, on: :create

  validates :role, inclusion: { in: %w[landlord tenant] }
  validates :name, presence: true

  has_many :units, foreign_key: "tenant_id", dependent: :destroy
  has_many :leases, foreign_key: "tenant_id", dependent: :destroy
  has_many :payments, foreign_key: "tenant_id", dependent: :destroy
  has_many :owned_properties, class_name: "Property", foreign_key: "landlord_id", dependent: :destroy

  has_many :rented_properties, through: :units, source: :property

  def landlord?
    role == "landlord"
  end

  def tenant?
    role == "tenant"
  end

  def admin?
    admin
  end

  private

  def set_default_role
    self.role ||= "tenant"
  end
end

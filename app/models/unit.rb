# == Schema Information
#
# Table name: units
#
#  id          :integer          not null, primary key
#  unit_number :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  property_id :integer
#  tenant_id   :integer
#
class Unit < ApplicationRecord
end

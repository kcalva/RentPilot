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
end

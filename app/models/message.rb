# == Schema Information
#
# Table name: messages
#
#  id          :bigint           not null, primary key
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  receiver_id :integer
#  sender_id   :integer
#
class Message < ApplicationRecord
  validates :content, presence: true
  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
end

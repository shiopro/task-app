# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :text
#  end_date    :datetime
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  board_id    :integer
#  user_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Task < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :title, presence: true
  validates :description, presence: true

  has_one_attached :eyecatch
end

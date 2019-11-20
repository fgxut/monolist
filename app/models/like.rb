class Like < ApplicationRecord
  belongs_to :user
  belongs_to :item
  counter_culture :item
  validates :user_id, presence: true
  validates :item_id, presence: true
end

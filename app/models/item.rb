# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :iine_users, through: :likes, source: :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
  validate  :picture_size

  def iine(user)
    likes.create(user_id: user.id)
  end

  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end

  def iine?(user)
    iine_users.include?(user)
  end

  private

  def picture_size
    errors.add(:picture, '5MB未満でなければなりません') if picture.size > 5.megabytes
  end
end

class User < ApplicationRecord
  validates :user_name, presence: true, length: { maximum: 50}
  validates :account_name, presence: true, length: { maximum: 14}, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
end

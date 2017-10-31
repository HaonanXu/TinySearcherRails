class User < ApplicationRecord
  has_many :user_activities

  validates :name, presence: true
  validates :password, presence: true, confirmation: true
  validates :email, presence: true, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, on: :create

  has_secure_password
end

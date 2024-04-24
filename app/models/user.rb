class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :lesson_users
  has_many :course_users

  scope :sign_ups_by_day, lambda {
    User.where('created_at > ?', 1.week.ago)
        .group_by_day(:created_at, format: '%A')
        .count
  }
end

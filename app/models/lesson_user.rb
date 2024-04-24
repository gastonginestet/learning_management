class LessonUser < ApplicationRecord
  belongs_to :lesson
  belongs_to :user

  scope :completed_lessons_by_day, lambda {
    LessonUser.where('created_at > ?', 1.week.ago)
              .where(completed: true)
              .group_by_day(:created_at, format: '%A')
              .count
  }
end

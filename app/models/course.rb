class Course < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100,100]
  end

  has_many :lessons
  has_many :course_users
  has_and_belongs_to_many :categories

  has_rich_text :description
  has_rich_text :premium_description

  scope :most_popular_courses, lambda {
    Course.joins(:course_users)
          .group(:id)
          .order('count(course_users.id) desc')
          .limit(5)
  }

  def first_lesson
    self.lessons.order(:position).first
  end

  def next_lesson(current_user)
    return self.lessons.order(:position).first unless current_user.present?

    completed_lessons = current_user.lesson_users.includes(:lesson).where(completed: true).where(lessons: { course_id: self.id})
    started_lessons = current_user.lesson_users.includes(:lesson).where(completed: false).where(lesson: { course_id: self.id}).order(:position)

    return started_lessons.first.lesson if started_lessons.any?

    lessons = self.lessons.where.not(id: completed_lessons.pluck(:lesson_id)).order(:position)
    return lessons.first if lessons.any?

    self.lessons.order(:position).first
  end
end

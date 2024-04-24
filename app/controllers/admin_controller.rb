# This is the AdminController class.
class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @quick_stats = {
      sign_ups: User.where('created_at > ?', 1.week.ago).count,
      sales: CourseUser.where('created_at > ?', 1.week.ago).count,
      completed_lessons: LessonUser.where('created_at > ?', 1.week.ago).where(completed: true).count,
      total_sign_ups: User.count
    }
    @completed_lessons_by_day = LessonUser.completed_lessons_by_day

    @sign_ups_by_day = User.sign_ups_by_day

    @most_popular_courses = Course.most_popular_courses
  end
end

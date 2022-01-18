class Course < ApplicationRecord
    # association for enrollments and enrolled_students

    has_many :enrollments,
        primary_key: :id,
        foreign_key: :course_id,
        class_name: :Enrollment

    has_many :enrolled_students,
        through: :enrollments,
        source: :user

    # association for prerequisite

    belongs_to :prerequisite,
        primary_key: :id,
        foreign_key: :prereq_id,
        class_name: :Course

    # association for instructor
    
    belongs_to :instructor,
        primary_key: :id,
        foreign_key: :instructor_id,
        class_name: :User
end

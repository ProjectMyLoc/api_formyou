class Usersession < ApplicationRecord
  belongs_to :student, class_name: "User", foreign_key: "student_id"
  belongs_to :session
end
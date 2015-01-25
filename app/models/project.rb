class Project < ActiveRecord::Base
  validates :title, presence: {message: "Provide a title please. "}, uniqueness: true
  # this last bit nullifies the question_id of all associated answers.
  has_many :tasks, dependent: :nullify
  has_many :discussions, through: :tasks
  has_many :comments, through: :discussions


end

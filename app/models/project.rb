class Project < ActiveRecord::Base
  # validates :title, presence: {message: "Provide a title please. "}, uniqueness: true
  validates :title, presence: true, uniqueness: true
  # this last bit nullifies the question_id of all associated answers.
  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :comments, through: :discussions

  # def banana
  #   puts "hello from project!"
  #   puts "my id is: #{self.id}"
  # end
end

class Discussion < ActiveRecord::Base
  # checks for the presence of the title, note that these error messages are 
  # not shown with the flash messsages. Instead they become part of an array
  # of error messages that will be attached to instances of this class.
  validates :title, presence: {message: "A Discussiong title must be provided!!!"}
  validates :description, presence: {message: "A Discussiong title must be provided!!!"}

  # this last bit nullifies the question_id of all associated answers.
  has_many :comments, dependent: :destroy 

  belongs_to :project
end

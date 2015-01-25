class Discussion < ActiveRecord::Base
  #checks for the presence of the title
  validates :title, presence: {message: "A Discussiong title must be provided!!!"}
 
  # this last bit nullifies the question_id of all associated answers.
  has_many :comments, dependent: :nullify 

  # belongs_to :task
end

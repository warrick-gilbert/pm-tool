class Task < ActiveRecord::Base
  #checks for the combined uniqueness of the title AND the foreign key.
  validates :title, presence: {message: "A Task title must be provided!!!"}, uniqueness: {scope: :project_id} 

  belongs_to :project

  # # this last bit nullifies the project_id of all associated answers.
  # has_many :discussions, dependent: :nullify 
end

class Task < ActiveRecord::Base
  #checks for the combined uniqueness of the title AND the foreign key.
  validates :title, presence: {message: " - You have to provide a task. "}, uniqueness: {scope: :project_id} 

  belongs_to :project

end

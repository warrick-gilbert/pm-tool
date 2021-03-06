class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects
  has_many :tasks
  has_many :discussions
  has_many :comments

  has_many :projects, through: :members
  has_many :members, dependent: :destroy

  has_many :favourites, dependent: :destroy
  has_many :favourite_projects, through: :favourites, source: :project

  # returns T/F if the user has favourited this 
  def favourited_this?(project_banana)
    # Favourite.where(user_id: this.id, project_id: project_banana.id).present?
    favourite_projects.include? project_banana
  end

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}".squeeze.strip
    else
      email
    end
  end

  def find_favourites
    # finds all the favourites for this user, this only return that weird
    # array like thing. then i use the map method, which takes each 
    # element in the array like thing, and finds the project_id, and then
    # with this number it goes to the Project and finds each project object,
    # and then it shows the title of each projct object.
    favourites.map{ |ff|  Project.find(ff.project_id).title  }
  end

end

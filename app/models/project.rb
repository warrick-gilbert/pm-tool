class Project < ActiveRecord::Base
  # validates :title, presence: {message: "Provide a title please. "}, uniqueness: true
  validates :title, presence: true, uniqueness: true
  # this last bit nullifies the question_id of all associated answers.
  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :comments, through: :discussions
  belongs_to :user

  has_many :users, through: :members
  has_many :members, dependent: :destroy

  has_many :tagifications, dependent: :destroy
  has_many :tags, through: :tagifications

  has_many :favourites, dependent: :destroy
  has_many :favourited_by_users, through: :favourites, source: :user

  # def banana
  #   puts "hello from project!"
  #   puts "my id is: #{self.id}"
  # end

  # def do_something
  #   puts "do_something"
  #   render text: "stopped!"
  # end
end

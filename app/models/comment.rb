class Comment < ActiveRecord::Base
  validates :body, presence: {message: "Comment title must be provided!!!"}

  belongs_to :discussion
  belongs_to :user

end

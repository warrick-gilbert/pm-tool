class Comment < ActiveRecord::Base
  validates :title, presence: {message: "Comment title must be provided!!!"}

  belongs_to :discussion

end

class Tagification < ActiveRecord::Base
  belongs_to :tag
  belongs_to :project
end

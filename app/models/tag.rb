class Tag < ActiveRecord::Base
  has_many :tagifications, dependent: :destroy
  has_many :projects, through: :tagifications

  validates :name, presence: true, uniqueness: true

end

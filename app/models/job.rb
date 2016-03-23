class Job < ActiveRecord::Base
  has_and_belongs_to_many :volunteers
  has_many :work_days
  validates :title, presence: true

  default_scope { order('title ASC') }
end

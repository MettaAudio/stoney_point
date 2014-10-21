class Job < ActiveRecord::Base
  has_many :committee
  has_many :volunteer
  has_many :work_days
  validates :title, presence: true

  default_scope { order('title ASC') }
end

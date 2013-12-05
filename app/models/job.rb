class Job < ActiveRecord::Base
  belongs_to :committee
  has_many :work_days
  validates :title, presence: true
end

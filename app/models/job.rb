class Job < ActiveRecord::Base
  belongs_to :committee
  belongs_to :volunteer
  has_many :work_days
  validates :title, presence: true

  default_scope order('title ASC')
end

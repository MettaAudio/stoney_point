class Committee < ActiveRecord::Base
  has_and_belongs_to_many :volunteers
  has_many :jobs
  validates :name, presence: true
end

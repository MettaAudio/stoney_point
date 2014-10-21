class Committee < ActiveRecord::Base
  has_and_belongs_to_many :volunteers
  validates :name, presence: true

  default_scope { order('name ASC') }
end

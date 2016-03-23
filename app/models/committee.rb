class Committee < ActiveRecord::Base
  has_and_belongs_to_many :volunteers
  validates :name, presence: true

  scope :scheduleable, -> {where.not(name: ['*Not Assigned','Operations'])}

  default_scope { order('name ASC') }
end

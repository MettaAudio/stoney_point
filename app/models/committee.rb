class Committee < ActiveRecord::Base
  has_and_belongs_to_many :volunteers
  validates :name, presence: true

  scope :scheduleable, -> {where.not(name: [PersonForm::DEFAULT_COMMITTEE_NAME,'Operations'])}
  scope :sorted, -> { order('name ASC') }
end

class Committee < ActiveRecord::Base
  has_and_belongs_to_many :volunteers
  validates :name, presence: true

  JUNIOR_CLINIC = "Junior Clinic"
  EXCLUDED_FROM_SCHEDULING = ['ProShop', JUNIOR_CLINIC]

  scope :scheduleable, -> {where.not(name: [PersonForm::DEFAULT_COMMITTEE_NAME,'Operations'])}
  scope :sorted, -> { order('name ASC') }
  scope :junior_clinic, -> { where(name: JUNIOR_CLINIC) }

end

class Caddie < ActiveRecord::Base
  belongs_to :golfer
  belongs_to :person

  delegate  :first_name,
            :last_name,
            :full_name,
            :phone,
            :email,
            :is_active,
            :organization,
            to: :person

  KNOWLEDGE_OPTIONS = ['High', 'Moderate', 'Low']

  scope :by_last_name, -> { includes(:person).order('people.last_name ASC') }
  scope :active, -> { joins(:person).where('people.is_active = ?', true) }
end

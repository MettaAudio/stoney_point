class Golfer < ActiveRecord::Base
  has_many :caddies
  has_and_belongs_to_many :housings
  belongs_to :person

  delegate  :first_name,
            :last_name,
            :email,
            :is_active,
            to: :person

  default_scope { includes(:person).order('people.last_name ASC') }
  scope :active, -> { includes(:person).where('people.is_active = ?', true) }

  def full_name
    inactive_text = is_active ? "" : "(I)"
    [person.first_name, person.last_name, inactive_text].join(' ')
  end
end

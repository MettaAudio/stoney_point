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
    [person.first_name, tagged_last_name].join(' ')
  end

  def tagged_last_name
    additional_text = ''
    if !is_active
      additional_text = "*"
    elsif housings.blank?
      additional_text = "(a)"
    end
    person.last_name + additional_text
  end

end

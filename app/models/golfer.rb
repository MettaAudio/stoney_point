class Golfer < ActiveRecord::Base
  has_many :caddies
  has_and_belongs_to_many :housings
  validates :first_name, presence: true
  validates :last_name,  presence: true

  default_scope { order('last_name ASC') }

  def full_name
    [first_name, last_name].join(' ')
  end
end

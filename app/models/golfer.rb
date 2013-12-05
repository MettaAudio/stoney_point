class Golfer < ActiveRecord::Base
  has_many :caddies
  validates :first_name, presence: true
  validates :last_name,  presence: true
end

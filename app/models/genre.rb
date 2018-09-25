class Genre < ActiveRecord::Base
  has_many :genres
  validates_presence_of :name
end

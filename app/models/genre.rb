class Genre < ActiveRecord::Base
  has_many :films
  validates_presence_of :name
end

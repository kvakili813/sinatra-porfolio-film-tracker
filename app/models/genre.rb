class Genre < ActiveRecord::Base
  has_many :films
  validates_presence_of :name
  validates_uniqueness_of :name
end

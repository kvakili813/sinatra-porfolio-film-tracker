class Genre < ActiveRecord::Base
  has_many :films
  has_secure_password
  validates_presence_of :username
  validates_uniqueness_of :username
end

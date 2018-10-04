class Film < ActiveRecord::Base
  belongs_to :user
  belongs_to :genre
  validates_presence_of :title, :year
end

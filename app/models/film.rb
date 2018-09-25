class Film < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates_presence_of :title, :year
end

class Location < ActiveRecord::Base
  has_many :games
  
  validates_presence_of :name
  validates_length_of :name, :within => 5..50
  
  scope :by_name, order('name')
end

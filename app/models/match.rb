class Match < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  
  acts_as_list :scope => :game
end

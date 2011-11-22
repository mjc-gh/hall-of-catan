class Player < ActiveRecord::Base
  attr_accessible :first_name, :last_name

  has_and_belongs_to_many :games, :uniq => true
  has_many :wins, :class_name => 'Game', :foreign_key => :winner_id

  validates_length_of :first_name, :within => 2..30
  validates_length_of :last_name, :within => 2..30
  validates_presence_of :first_name, :last_name
  
  default_scope order('first_name, last_name')
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def initials
    "#{first_name[0]}#{last_name[0]}"
  end
end

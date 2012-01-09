class Player < ActiveRecord::Base
  attr_accessible :first_name, :last_name

  # See https://github.com/rails/rails/issues/520
  has_many :matches
  has_many :games, :through => :matches, :select => 'DISTINCT games.*, matches.position', :order => 'played_on DESC', :uniq => true
  #has_many :games, :through => :matches, :uniq => true, :order => 'matches.position'
  
    
  has_many :wins, :class_name => 'Game', :foreign_key => :winner_id

  validates_length_of :first_name, :within => 2..30
  validates_length_of :last_name, :within => 2..30
  validates_presence_of :first_name, :last_name
  
  scope :by_name, order('first_name, last_name')
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def initials
    "#{first_name[0]}#{last_name[0]}"
  end
end

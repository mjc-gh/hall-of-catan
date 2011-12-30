class Game < ActiveRecord::Base
  VERSIONS = { 1 => 'Settlers of Catan', 2 => 'Seafarers of Catan' }
  
  self.per_page = 5
  
  # See https://github.com/rails/rails/issues/520
  has_many :matches
  #has_many :players, :through => :matches, :uniq => true, :order => 'matches.position' do
  has_many :players, :through => :matches, :select => 'DISTINCT players.*, matches.position', 
           :order => 'matches.position', :uniq => true do
    def without(player)
      players = self.dup
      players.delete(player)
      
      players
    end
  end
  
  belongs_to :location
  belongs_to :winner, :class_name => 'Player', :foreign_key => :winner_id
  
  validates_presence_of :winner_id, :location_id, :played_on
  validates_associated :winner, :location
  validates_inclusion_of :version, :in => VERSIONS.keys
  
  validate :has_players
  validate :winner_in_players

  scope :recent, order('played_on DESC, created_at DESC')

  after_create do |game|
    Player.increment_counter :win_count, game.winner.id if game.winner
    
    game.players.each do |player|
      Player.increment_counter :game_count, player.id
    end
  end

  def version_value
    VERSIONS[version]
  end

  protected

  def has_players
    errors[:base] << "Game must at least two players." if players.size < 2
  end
  
  def winner_in_players
    errors[:winner] << "is not in players list" unless players.include?(winner)
  end
end

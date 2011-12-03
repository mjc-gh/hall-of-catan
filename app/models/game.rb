class Game < ActiveRecord::Base
  has_and_belongs_to_many :players, :uniq => true do
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
  
  validate :has_players
  validate :winner_in_players

  default_scope order('played_on DESC, created_at DESC')

  after_create do |game|
    Player.increment_counter :win_count, game.winner.id if game.winner
    
    game.players.each do |player|
      Player.increment_counter :game_count, player.id
    end
  end

  protected

  def has_players
    errors[:base] << "Game must at least two players." if players.size < 2
  end
  
  def winner_in_players
    errors[:winner] << "is not in players list" unless players.include?(winner)
  end
end

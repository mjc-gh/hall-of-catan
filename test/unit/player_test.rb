require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "game association" do
    player = Factory.create(:player)
    game = Factory.create(:game, :players => [player])
    
    assert_equal player, game.players.first
    assert_equal 1, player.games.size
  end
  
  test "wins association" do
    player = Factory.create(:player)
    game = Factory.create(:game, :players => [player], :winner => player)
    
    assert_equal player, game.winner
    assert_equal 1, player.wins.size
  end
  
  test "game count" do
    p1 = Factory.create(:player)
    p2 = Factory.create(:player)
    
    game = Factory.create(:game, :players => [p1, p2], :winner => p1)
    
    p1.reload
    p2.reload
    
    assert game.valid?
    assert_equal 1, p1.game_count
    assert_equal 1, p2.game_count
  end
  
  test "win count" do
    p1 = Factory.create(:player)
    p2 = Factory.create(:player)
    
    game = Factory.create(:game, :players => [p1, p2], :winner => p1)
    
    p1.reload
    p2.reload
    
    assert game.valid?
    assert_equal 1, p1.win_count
    assert_equal 0, p2.win_count
  end
end

require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "game association" do
    p1 = Factory.create(:player)
    p2 = Factory.create(:player)
    
    game = Factory.create(:game, :players => [p1, p2], :winner => p1)
    
    assert_equal p1, game.players.first
    assert_equal 1, p1.games.size
  end
  
  test "wins association" do
    p1 = Factory.create(:player)
    p2 = Factory.create(:player)
    
    game = Factory.create(:game, :players => [p1, p2], :winner => p1)
    
    assert_equal p1, game.winner
    assert_equal 1, p1.wins.size
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

require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "game association" do
    p1 = create(:player)
    p2 = create(:player)
    
    game = create(:game, :players => [p1, p2], :winner => p1)
    
    assert_equal p1, game.players.first
    assert_equal 1, p1.games.size
  end
  
  test "wins association" do
    p1 = create(:player)
    p2 = create(:player)
    
    game = create(:game, :players => [p1, p2], :winner => p1)
    
    assert_equal p1, game.winner
    assert_equal 1, p1.wins.size
  end
  
  test "game count" do
    p1 = create(:player)
    p2 = create(:player)
    
    game = create(:game, :players => [p1, p2], :winner => p1)
    
    p1.reload
    p2.reload
    
    assert game.valid?
    assert_equal 1, p1.game_count
    assert_equal 1, p2.game_count
  end
  
  test "win count" do
    p1 = create(:player)
    p2 = create(:player)
    
    game = create(:game, :players => [p1, p2], :winner => p1)
    
    p1.reload
    p2.reload
    
    assert game.valid?
    assert_equal 1, p1.win_count
    assert_equal 0, p2.win_count
  end
  
  test "game order" do
    p1 = create(:player)
    p2 = create(:player)    
    
    g1 = create(:game, :played_on => (Time.now - 2.days).to_date, :players => [p1, p2], :winner => p1)
    g2 = create(:game, :played_on => (Time.now - 1.day).to_date, :players => [p1, p2], :winner => p1)
    g3 = create(:game, :played_on => (Time.now).to_date, :players => [p1, p2], :winner => p1)
    
    assert p1.valid?
    
    assert_equal g3, p1.games[0]
    assert_equal g2, p1.games[1]
    assert_equal g1, p1.games[2]
  end
end

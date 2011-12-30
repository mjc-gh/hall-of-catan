require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "players associations" do
    game = build(:game, :players => [])
    
    assert !game.valid?
    assert game.errors[:base].any?
    
    player = create(:player)    
    game = build(:game, :players => [player])
    
    assert !game.valid?
    assert game.errors[:base].any?
    
    game = build(:game, :players => [player, player])
    
    assert !game.valid?
    assert game.errors[:base].any?
    
    other = create(:player)
    game = build(:game, :players => [player, other])
    
    assert game.valid?
  end
  
  test "players order" do
    p1 = create(:player); p2 = create(:player)
    p3 = create(:player); p4 = create(:player)
    
    game = build(:game, :players => [p3, p1, p4, p2])
    
    assert game.save
    game = Game.find(game.id)
    
    assert_equal p3, game.players[0]
    assert_equal p1, game.players[1]
    assert_equal p4, game.players[2]
    assert_equal p2, game.players[3]
  end
  
  test "location assocaition" do
    game = build(:game, :location => nil)
    
    assert game.invalid?
    assert_includes game.errors, :location_id
    
    game = build(:game)
    
    assert game.valid?
  end
  
  test "winner association" do
    game = build(:game, :winner => nil)
    
    assert game.invalid?
    assert_includes game.errors, :winner_id
    
    game = build(:game)
    
    assert game.valid?
  end
  
  test "winner not in players" do
    winner = create(:player)
    game = build(:game, :winner => winner)
    
    assert game.invalid?
    assert_includes game.errors, :winner
  end
  
  test "catan version" do
    game = build(:game, :version => nil)
    
    assert game.invalid?
    assert_includes game.errors, :version
    
    game = build(:game)
    assert game.valid?
  end
end

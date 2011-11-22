require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "players associations" do
    game = Factory.build(:game, :players => [])
    
    assert !game.valid?
    assert game.errors[:base].any?
    
    player = Factory.create(:player)    
    game = Factory.build(:game, :players => [player])
    
    assert !game.valid?
    assert game.errors[:base].any?
    
    game = Factory.build(:game, :players => [player, player])
    
    assert !game.valid?
    assert game.errors[:base].any?
    
    other = Factory.create(:player)
    game = Factory.build(:game, :players => [player, other])
    
    assert game.valid?
  end
  
  test "location assocaition" do
    game = Factory.build(:game, :location => nil)
    
    assert !game.valid?
    assert game.errors[:location_id].any?
    
    game = Factory.build(:game)
    
    assert game.valid?
    assert game.errors[:location].empty?
  end
  
  test "winner association" do
    game = Factory.build(:game, :winner => nil)
    
    assert !game.valid?
    assert game.errors[:winner_id].any?
    
    game = Factory.build(:game)
    
    assert game.valid?
    assert game.errors[:winner].empty?
  end
  
  test "winner not in players" do
    winner = Factory.create(:player)
    game = Factory.build(:game, :winner => winner)
    
    assert !game.valid?
    assert game.errors[:winner].any?
  end
end

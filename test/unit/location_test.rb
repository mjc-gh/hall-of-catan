require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "game association" do
    location = Factory.create(:location)
    game = Factory.create(:game, :location => location)
    
    assert_equal location, game.location
    assert_equal 1, location.games.size
  end
end

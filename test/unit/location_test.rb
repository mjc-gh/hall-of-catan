require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "game association" do
    location = create(:location)
    game = create(:game, :location => location)
    
    assert_equal location, game.location
    assert_equal 1, location.games.size
  end
end

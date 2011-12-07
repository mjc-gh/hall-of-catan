class DropTableGamesPlayers < ActiveRecord::Migration
  def up
    drop_table :games_players
  end

  def down
  end
end

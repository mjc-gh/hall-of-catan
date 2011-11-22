class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string         :first_name
      t.string         :last_name
      
      t.integer        :game_count, :default => 0
      t.integer        :win_count, :default => 0
      
      t.timestamps
    end
  end
end

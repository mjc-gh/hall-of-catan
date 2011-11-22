class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references     :winner
      t.references     :location
      
      t.date           :played_on
      t.text           :notes
      
      t.timestamps
    end
  end
end

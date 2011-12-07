class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :game
      t.references :player
      
      t.integer    :position
      
      t.timestamps
    end
  end
end

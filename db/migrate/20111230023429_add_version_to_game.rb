class AddVersionToGame < ActiveRecord::Migration
  def change
    add_column :games, :version, :integer
  end
end

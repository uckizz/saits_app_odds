class AddGamedayToPlayedGames < ActiveRecord::Migration[5.1]
  def change
    add_column :played_games, :matchday, :integer
  end
end

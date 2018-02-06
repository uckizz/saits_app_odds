class CreatePlayedGames < ActiveRecord::Migration[5.1]
  def change
    create_table :played_games do |t|
      t.string :hometeam
      t.string :awayteam
      t.string :homescore
      t.string :awayscore
      t.string :date

      t.timestamps
    end
  end
end

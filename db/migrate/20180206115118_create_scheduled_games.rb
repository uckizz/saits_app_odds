class CreateScheduledGames < ActiveRecord::Migration[5.1]
  def change
    create_table :scheduled_games do |t|
      t.string :hometeam
      t.string :awayteam
      t.integer :matchday
      t.float :homebet
      t.float :drawbet
      t.float :awaybet
      t.date :matchdate

      t.timestamps
    end
  end
end

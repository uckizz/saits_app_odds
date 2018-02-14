class CreateBookieOdds < ActiveRecord::Migration[5.1]
  def change
    create_table :bookie_odds do |t|
      t.string :hometeam
      t.string :awayteam
      t.decimal :homeodds
      t.decimal :drawodds
      t.decimal :awayodds
      t.date :matchdate
      t.string :homebookie
      t.string :drawbookie
      t.string :awaybookie

      t.timestamps
    end
  end
end

class CreateDecks < ActiveRecord::Migration[5.2]
  def change
    create_table :decks do |t|
      t.string :name
      t.string :imagefile_name
      t.string :comment
      t.string :number_of_use
      t.string :number_of_wins
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

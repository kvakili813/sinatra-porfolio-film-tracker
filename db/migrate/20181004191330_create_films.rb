class CreateFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
      t.string :title
      t.integer :year
      t.integer :user_id
      t.integer :genre_id
    end
  end
end

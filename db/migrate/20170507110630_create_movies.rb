class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :poster
      t.string :description
      t.string :genere

      t.timestamps null: false
    end
  end
end
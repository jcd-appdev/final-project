class CreateSavedSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_songs do |t|
      t.integer :search_id

      t.timestamps
    end
  end
end

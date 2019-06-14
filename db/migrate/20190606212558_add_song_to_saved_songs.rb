class AddSongToSavedSongs < ActiveRecord::Migration[5.1]
  def change
      add_column :saved_songs, :song, :string
      add_column :saved_songs, :artist, :string

  end
end

class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string :text
      t.boolean :song_saved
      t.integer :user_id

      t.timestamps
    end
  end
end

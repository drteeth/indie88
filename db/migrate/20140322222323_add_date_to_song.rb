class AddDateToSong < ActiveRecord::Migration
  def change
    add_column :songs, :date, :date
    add_index :songs, :date
  end
end

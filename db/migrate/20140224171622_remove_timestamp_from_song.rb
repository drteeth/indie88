class RemoveTimestampFromSong < ActiveRecord::Migration
  def change
    remove_column :songs, :timestamp, :string
  end
end

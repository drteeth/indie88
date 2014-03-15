class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.datetime :timestamp
      t.string :songuuid
      t.string :streamuuid
      t.string :songartist
      t.string :songtitle
      t.string :songartwork
      t.string :songituneslink
      t.string :songitunespreview
      t.string :cutid

      t.timestamps
    end
  end
end

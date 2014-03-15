class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.boolean :has_female_member
      t.boolean :is_female_fronted

      t.timestamps
    end
  end
end

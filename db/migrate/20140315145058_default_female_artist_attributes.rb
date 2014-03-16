class DefaultFemaleArtistAttributes < ActiveRecord::Migration
  def change
    change_column :artists, :has_female_member, :boolean, null: false, default: false
    change_column :artists, :is_female_fronted, :boolean, null: false, default: false
  end
end

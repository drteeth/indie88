class ReplaceBoolsWithFemlevel < ActiveRecord::Migration
  def change
    remove_column :artists, :has_female_member
    remove_column :artists, :is_female_fronted
    add_column :artists, :fem_level, :integer, default: 0, null: false
  end
end

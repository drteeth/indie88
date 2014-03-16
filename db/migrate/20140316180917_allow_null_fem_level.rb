class AllowNullFemLevel < ActiveRecord::Migration
  def change
    change_column :artists, :fem_level, :integer, null: true, default: nil
  end
end

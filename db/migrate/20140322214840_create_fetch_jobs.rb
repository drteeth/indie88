class CreateFetchJobs < ActiveRecord::Migration
  def change
    create_table :fetch_jobs do |t|
      t.date :date, null: false
      t.string :status, null: false, default: 'enqueued'
      t.string :last_message

      t.timestamps
    end

    add_index :fetch_jobs, :date
    add_index :fetch_jobs, :status
  end
end

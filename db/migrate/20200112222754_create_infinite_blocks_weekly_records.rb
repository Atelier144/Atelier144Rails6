class CreateInfiniteBlocksWeeklyRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :infinite_blocks_weekly_records do |t|
      t.integer :user_id
      t.integer :score
      t.integer :level

      t.timestamps
    end
  end
end

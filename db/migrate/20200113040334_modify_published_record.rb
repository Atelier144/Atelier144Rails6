class ModifyPublishedRecord < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :is_published_record, :string
    add_column :users, :is_published_record, :boolean
  end
end

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :image
      t.string :description
      t.string :url
      t.string :twitter_uid
      t.string :twitter_url
      t.boolean :is_published_profile
      t.boolean :is_published_description
      t.boolean :is_published_url
      t.boolean :is_published_twitter_url
      t.string :is_published_record
      t.string :reset_password_token

      t.timestamps
    end
  end
end

class AddTwitterToken < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :twitter_access_token, :string
    add_column :users, :twitter_access_token_secret, :string
  end
end
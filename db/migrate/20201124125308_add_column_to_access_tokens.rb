class AddColumnToAccessTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :access_tokens, :expired, :boolean, default: false
  end
end

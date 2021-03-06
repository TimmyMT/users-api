class CreateAccessTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :access_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token, null: false, default: ''
      t.timestamp :expires_in

      t.timestamps
    end
  end
end

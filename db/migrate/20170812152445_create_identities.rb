class CreateIdentities < ActiveRecord::Migration[5.2]
  def change
    create_table :identities do |t|
      t.timestamps

      t.string :token, null: false, default: ''
      
      t.references :member
      t.string :provider, limit: 50, null: false, default: ''
      t.string :uid, limit: 500, null: false, default: ''
      t.string :credential_token, limit: 50, null: false, default: ''
      t.string :credential_secret, limit: 200, null: false, default: ''

    end
  end
end

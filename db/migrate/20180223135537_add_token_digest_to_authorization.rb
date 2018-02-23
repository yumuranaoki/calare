class AddTokenDigestToAuthorization < ActiveRecord::Migration[5.1]
  def change
    add_column :authorizations, :token_digest, :string
  end
end

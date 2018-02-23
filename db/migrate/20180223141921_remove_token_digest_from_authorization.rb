class RemoveTokenDigestFromAuthorization < ActiveRecord::Migration[5.1]
  def change
    remove_column :authorizations, :token_digest, :string
  end
end

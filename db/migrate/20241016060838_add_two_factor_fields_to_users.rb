class AddTwoFactorFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :two_factor_enabled, :boolean, default: false
    add_column :users, :two_factor_code, :string
    add_column :users, :two_factor_expiry, :datetime
  end
end

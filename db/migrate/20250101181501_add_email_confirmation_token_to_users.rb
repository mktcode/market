class AddEmailConfirmationTokenToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :email_confirmation_token, :string
  end
end

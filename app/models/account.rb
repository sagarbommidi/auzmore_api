class Account < ApplicationRecord
  self.table_name = :account
  has_many :phone_numbers

  def self.authenticate(username, auth_id)
    account = find_by(username: username, auth_id: auth_id)
    !account.nil?
  end
end

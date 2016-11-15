class AddSecuritylevelIdToSecuritySettings < ActiveRecord::Migration
  def change
    add_column :security_settings, :securitylevel_id, :integer
  end
end

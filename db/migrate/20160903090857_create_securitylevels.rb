class CreateSecuritylevels < ActiveRecord::Migration
  def change
    create_table :securitylevels do |t|
      t.string :securitylevel

      t.timestamps null: false
    end
  end
end

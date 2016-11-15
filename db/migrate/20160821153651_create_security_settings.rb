class CreateSecuritySettings < ActiveRecord::Migration
  def change
    create_table :security_settings do |t|

    	t.string :name
    	t.integer :securable_id
    	t.string :securable_type

   		t.timestamps null: false
    end

    add_index :security_settings, [:securable_type, :securable_id]
  
  end

end

class CreateBios < ActiveRecord::Migration
  def change
    create_table :bios do |t|
      t.string :work_place
      t.string :designation
      t.string :college
      t.string :school
      t.string :university
      t.string :university_degree
      t.string :school_cert
      t.string :college_cert
      t.string :home_town

      t.timestamps null: false
    end
  end
end

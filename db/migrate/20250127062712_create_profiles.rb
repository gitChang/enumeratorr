class CreateProfiles < ActiveRecord::Migration[7.1]
  def up
    create_table :profiles do |t|
      t.string :lastname
      t.string :firstname
      t.string :middlename
      # t.string :suffix

      t.string :birthdate
      t.string :sex

      t.string :address

      t.string :contactnumber
      t.string :email

      t.string :merged_names
      t.string :merged_names_two

      t.timestamps
    end
  end


  def down 
    drop_table :profiles
  end
end

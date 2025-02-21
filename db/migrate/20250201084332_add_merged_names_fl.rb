class AddMergedNamesFl < ActiveRecord::Migration[7.1]
  def up
    add_column :profiles, :merged_names_fl, :string
  end

  def down
    remove_column :profiles, :merged_names_fl
  end
end

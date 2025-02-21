class AddMergedNamesLf < ActiveRecord::Migration[7.1]
  def up
    add_column :profiles, :merged_names_lf, :string
  end
end

class RenameColumnOnCity < ActiveRecord::Migration
  def change
  	rename_column :cities, :countries_id, :country_id
  end
end

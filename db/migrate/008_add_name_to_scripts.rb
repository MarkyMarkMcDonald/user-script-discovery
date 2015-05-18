class AddNameToScripts < ActiveRecord::Migration
  def change
    add_column :scripts, :name, :text
  end
end

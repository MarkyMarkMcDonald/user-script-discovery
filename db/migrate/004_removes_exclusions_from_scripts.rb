class RemovesExclusionsFromScripts < ActiveRecord::Migration
  def change
    remove_column :scripts, :excludes
  end
end

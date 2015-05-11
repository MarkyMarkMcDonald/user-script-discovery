class RemovesInclusionsFromScripts < ActiveRecord::Migration
  def change
    remove_column :scripts, :includes
  end
end

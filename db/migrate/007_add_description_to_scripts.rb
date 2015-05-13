class AddDescriptionToScripts < ActiveRecord::Migration
  def change
    add_column :scripts, :description, :text
  end
end

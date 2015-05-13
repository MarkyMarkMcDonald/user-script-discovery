class AddContentToScripts < ActiveRecord::Migration
  def change
    add_column :scripts, :content, :text
  end
end

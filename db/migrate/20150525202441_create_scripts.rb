class CreateScripts < ActiveRecord::Migration
  def change
    create_table :scripts do |t|
      t.text :source
      t.text :link
      t.text :content
      t.text :description
      t.text :name
    end
  end
end

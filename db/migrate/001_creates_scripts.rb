class CreatesScripts < ActiveRecord::Migration
  def change
    create_table :scripts do |t|
      t.text :source
      t.text :link
      t.text :includes, array: true, default: []
      t.text :excludes, array: true, default: []
    end
  end
end

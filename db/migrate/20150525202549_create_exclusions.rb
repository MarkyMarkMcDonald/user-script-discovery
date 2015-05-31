class CreateExclusions < ActiveRecord::Migration
  def change
    create_table :exclusions do |t|
      t.belongs_to :script, index: true
      t.text :pattern
    end
  end
end

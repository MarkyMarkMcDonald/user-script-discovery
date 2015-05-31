class CreateInclusions < ActiveRecord::Migration
  def change
    create_table :inclusions do |t|
      t.belongs_to :script, index: true
      t.text :pattern
    end
  end
end

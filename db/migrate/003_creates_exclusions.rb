class CreatesExclusions < ActiveRecord::Migration
  def change
    create_table :exclusions do |t|
      t.belongs_to :script, index: true
      t.text :pattern
    end

    Script.all.each do |script|
      script.excludes.each do |exclusion|
        Exclusion.create(script_id: script.id, pattern: exclusion)
      end
    end
  end
end

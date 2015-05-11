class CreatesInclusions < ActiveRecord::Migration
  def change
    create_table :inclusions do |t|
      t.belongs_to :script, index: true
      t.text :pattern
    end

    Script.all.each do |script|
      script.includes.each do |inclusion|
        Inclusion.create(script_id: script.id, pattern: inclusion)
      end
    end
  end
end

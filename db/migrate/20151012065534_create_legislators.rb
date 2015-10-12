class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.integer "legislator_id"
      t.string "name"
      t.string "party"
      t.string "constituency"

      t.timestamps null: false
    end
  end
end

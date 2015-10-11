class CreateFirefights < ActiveRecord::Migration
  def change
    create_table :firefights do |t|

      t.integer  "firefight_id"
      t.string   "name"
      t.string   "result"
      
      t.timestamps null: false
    end
  end
end
